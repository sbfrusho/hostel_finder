// app_router.dart
import 'package:go_router/go_router.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_up_screen.dart';

import '../../features/authentication/presentation/screens/dummy_home_page.dart';
import '../../features/authentication/presentation/screens/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/signin', builder: (_, __) => const SignInScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),
      GoRoute(path: '/signup',builder: (_,__) => const SignUpScreen()),
    ],
  );
}