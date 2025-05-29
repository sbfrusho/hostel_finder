import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  User? user;

  bool isChecking = true;

  AuthProvider() {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    user = _firebaseAuth.currentUser;
    isChecking = false;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = _firebaseAuth.currentUser;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = _firebaseAuth.currentUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    user = null;
    notifyListeners();
  }
}
