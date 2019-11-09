import 'dart:async';

import '../models/user.dart';

abstract class AuthenticationService {
  Future<User> currentUser();
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}
