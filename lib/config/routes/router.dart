// GoRouter setup & pathnames
import 'package:clean_architecture/features/authentication/presentation/login_screen.dart';
import 'package:clean_architecture/shared/screens/splash_screen.dart';
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
        name: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
