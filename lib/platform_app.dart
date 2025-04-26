import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/app_theme.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/features/auth/utils/auth_persistence.dart';
import 'package:hui_application/main.dart';
import 'package:hui_application/routes/app_routes.dart';

class PlatformApp extends ConsumerWidget {
  const PlatformApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authLoadState = ref.watch(authLoadProvider);
    return authLoadState.when(
      data: (_) {
        ref.listen<AuthState>(authProvider, (_, state) {
          if (state.isLoggedIn) {
            AuthPersistence.saveAuthData(state);
          } else {
            AuthPersistence.clearAuthData(ref);
          }
        });
        if (kIsWeb) {
          return MaterialApp.router(
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: true,
            routerConfig: router,
            theme: AppTheme.lightTheme,
          );
        }
        switch (defaultTargetPlatform) {
          case TargetPlatform.iOS:
            return CupertinoApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          case TargetPlatform.windows:
            return fluent.FluentApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          default:
            return MaterialApp.router(
              scaffoldMessengerKey: scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              routerConfig: router,
            );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, stack) =>
              Center(child: Text('Error loading auth data: $error')),
    );
  }
}
