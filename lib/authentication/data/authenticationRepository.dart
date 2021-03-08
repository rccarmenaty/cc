import 'dart:async';
import 'package:cc2021/authentication/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firabase_auth;
import 'package:meta/meta.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationeRepository {
  final firabase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationeRepository({firabase_auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firabase_auth.FirebaseAuth.instance;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? User.empty
          : User(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              username: firebaseUser.displayName,
              photo: firebaseUser.photoURL);
    });
  }

  Future<void> signUp(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> loginWithEmailAndPassword(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *TODO login with facebook
   */

  Future<void> logout() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),

        ///facebook signout
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
