import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:hui_application/app_theme.dart';
import 'package:hui_application/main.dart';
import 'package:hui_application/routes/app_routes.dart';

class PlatformApp extends StatelessWidget {
  const PlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
