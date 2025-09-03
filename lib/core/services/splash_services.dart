import 'dart:async';
import 'package:clean_architecture/config/routes/routes.dart';
import 'package:clean_architecture/core/constants/app_logs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashServices {
  // final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  void checkAuthentication(BuildContext context) async {
    try {
      // Check if user is authenticated with Firebase
      // final isLoggedIn = _authRepo.isLoggedIn;

      AppLogger(className: "SplashServices").info('User is  not logged in');

      Timer(const Duration(seconds: 2), () {
        context.goNamed(Routes.loginScreen);
        // if (isLoggedIn) {

        // If user is logged in, navigate to home screen
        // context.pushNamedAndRemoveUntil(RoutesName.homeScreen);
        // } else {
        // If not logged in, navigate to login screen
        // context.pushNamedAndRemoveUntil(RoutesName.loginScreen);
        // }
      });
    } catch (e) {
      // If any error occurs, still navigate to login screen after delay
      Timer(
        const Duration(seconds: 2),
        () {},
        // () => context.pushNamedAndRemoveUntil(RoutesName.loginScreen),
      );
    }
  }
}
