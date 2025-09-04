//  Main app widget

import 'package:clean_architecture/config/responsive/responsive_config.dart';
import 'package:clean_architecture/config/routes/router.dart';
import 'package:clean_architecture/core/localization/localization.dart';
import 'package:clean_architecture/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveConfig.init(context);
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: Localization.currentLocale,
      debugShowCheckedModeBanner: false,
    );
  }
}
