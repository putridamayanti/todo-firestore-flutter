import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthUnloaded extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  FirebaseUser user;

  AuthSuccess({ this.user });
}

class AuthError extends AuthState {}

class LogoutSuccess extends AuthState {}
