import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_finder/features/hostel/Screens/splash_screen.dart';
import 'package:hostel_finder/features/hostel/presentation/providers/hostel_provider.dart';
import 'package:provider/provider.dart';
import 'package:hostel_finder/injection.dart';

import 'features/authentication/presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => HostelProvider()),
      ],
      child: MaterialApp(
        title: 'Hostel Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
