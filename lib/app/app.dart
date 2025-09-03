//  Main app widget

import 'package:clean_architecture/app/router.dart';
import 'package:clean_architecture/core/localization/localization.dart';
import 'package:clean_architecture/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Localization.currentLocale,
    );
  }
}
