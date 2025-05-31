import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_finder/features/authentication/presentation/providers/auth_provider.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Firebase
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
}
