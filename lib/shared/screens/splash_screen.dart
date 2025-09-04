import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:clean_architecture/core/extensions/textstyle_extension.dart';
import 'package:clean_architecture/core/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    SplashServices().checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'My App',
          style: context.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
      ),
    );
  }
}
