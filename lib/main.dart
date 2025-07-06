import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/firebase_options.dart';
import 'package:hui_application/platform_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/utils/web_url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await init();
  configureAppUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: PlatformApp()));
}
