import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/providers/app_loading_provider.dart';
import 'package:hui_application/core/providers/app_locale_provider.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/main.dart';
import 'package:hui_application/routes/app_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hui_application/theme/theme.dart';
import 'package:hui_application/theme/util.dart';

class PlatformApp extends ConsumerWidget {
  const PlatformApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final router = ref.watch(routerProvider);
    final isLoading = ref.watch(appLoadingProvider);
    if (authState.type == AuthStateType.initial) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
        debugShowCheckedModeBanner: false,
      );
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          _buildRouter(router, context, ref),
          if (isLoading)
            Container(
              color: Colors.black.withAlpha(400),
              child: const Center(
                child: SpinKitSpinningLines(color: Colors.white, size: 50),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRouter(GoRouter router, BuildContext context, WidgetRef ref) {
    TextTheme textTheme = createTextTheme(context, "Inter", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    final locale = ref.watch(appLocaleProvider).value;
    if (kIsWeb) {
      return MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: theme.light(),
        darkTheme: theme.dark(),
        themeMode: ThemeMode.system,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: locale,
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
        );
      case TargetPlatform.windows:
        return fluent.FluentApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
        );
      default:
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          routerConfig: router,
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
        );
    }
  }
}
