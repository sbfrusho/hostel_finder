import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isChecking) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (auth.user != null) {
              context.go('/home');
            } else {
              context.go('/signin');
            }
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}
