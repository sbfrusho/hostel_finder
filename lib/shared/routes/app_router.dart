// app_router.dart
import 'package:go_router/go_router.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/splash_screen.dart';
import 'package:hostel_finder/features/hostel/Screens/add_post_screen.dart';
import 'package:hostel_finder/features/hostel/Screens/home_screen.dart';
import 'package:hostel_finder/features/hostel/Screens/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/signin', builder: (_, __) => const SignInScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/signup',builder: (_,__) => const SignUpScreen()),
      GoRoute(path: '/add-post', builder: (_, __) => const AddPostScreen()),
    ],
  );
}