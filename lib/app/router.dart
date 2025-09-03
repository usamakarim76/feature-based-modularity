// GoRouter setup & pathnames
import 'package:clean_architecture/features/authentication/presentation/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: Routes.home,
    routes: [
      // Define your routes here, e.g.,
      // GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );
}
