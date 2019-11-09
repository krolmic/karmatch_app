import 'dart:async';

import 'package:flutter/foundation.dart';

import './authentication_service.dart';
import './firebase_authentication_service.dart';
import '../models/user.dart';

enum AuthenticationServiceType {
  firebase,
}

class AuthServiceAdapter implements AuthenticationService {
  AuthServiceAdapter(
      {@required AuthenticationServiceType initialAuthServiceType})
      : authServiceTypeNotifier =
            ValueNotifier<AuthenticationServiceType>(initialAuthServiceType) {
    _setup();
  }

  final FirebaseAuthenticationService _firebaseAuthService =
      FirebaseAuthenticationService();

  // Value notifier used to switch between auth. services
  final ValueNotifier<AuthenticationServiceType> authServiceTypeNotifier;

  AuthenticationServiceType get authServiceType =>
      authServiceTypeNotifier.value;

  AuthenticationService get authService => _firebaseAuthService;

  StreamSubscription<User> _firebaseAuthSubscription;

  final StreamController<User> _onAuthStateChangedController =
      StreamController<User>.broadcast();

  void _setup() {
    // Observable<User>.merge was considered here, but we need more fine grained control to ensure
    // that only events from the currently active service are processed
    _firebaseAuthSubscription =
        _firebaseAuthService.onAuthStateChanged.listen((User user) {
      if (authServiceType == AuthenticationServiceType.firebase) {
        _onAuthStateChangedController.add(user);
      }
    }, onError: (dynamic error) {
      if (authServiceType == AuthenticationServiceType.firebase) {
        _onAuthStateChangedController.addError(error);
      }
    });
  }

  @override
  void dispose() {
    _firebaseAuthSubscription?.cancel();
    _onAuthStateChangedController?.close();
    authServiceTypeNotifier.dispose();
  }

  @override
  Stream<User> get onAuthStateChanged => _onAuthStateChangedController.stream;

  @override
  Future<User> currentUser() => authService.currentUser();

  @override
  Future<User> signInWithGoogle() => authService.signInWithGoogle();

  @override
  Future<void> signOut() => authService.signOut();
}
