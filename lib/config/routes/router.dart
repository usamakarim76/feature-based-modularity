// GoRouter setup & pathnames
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:clean_architecture/features/authentication/presentation/login_screen.dart';
import 'package:clean_architecture/features/authentication/presentation/register_screen.dart';
import 'package:clean_architecture/shared/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: Routes.splashScreen,
    routes: [
      // Define your routes here, e.g.,
      // GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: Routes.splashScreen,
        name: 'Splash',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => BlocProvider.value(
          value: sl<AuthenticationBloc>(),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: Routes.registerScreen,
        builder: (context, state) => BlocProvider.value(
          value: sl<AuthenticationBloc>(),
          child: const RegisterScreen(),
        ),
      ),
    ],
  );
}
