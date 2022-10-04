import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:myapp/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedin extends AuthState {
  final AuthUser user;
  const AuthStateLoggedin(this.user);
}



class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}

class AuthStateLogOutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogOutFailure(this.exception);
}
