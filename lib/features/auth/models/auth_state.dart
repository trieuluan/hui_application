import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hui_application/models/users.dart';

part 'auth_state.freezed.dart';

enum AuthStateType {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  otpSent,
  otpVerified,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({
    required String token,
    required User user,
  }) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.otpSent() = _OtpSent;
  const factory AuthState.otpVerified() = _OtpVerified;
  const factory AuthState.error(String message) = _Error;
}

extension AuthStateX on AuthState {
  bool get isAuthenticated => this is _Authenticated;

  String? get token {
    if (this is _Authenticated) {
      return (this as _Authenticated).token;
    }
    return null;
  }

  User? get user {
    if (this is _Authenticated) {
      return (this as _Authenticated).user;
    }
    return null;
  }

  String? get errorMessage {
    if (this is _Error) {
      return (this as _Error).message;
    }
    return null;
  }
}

extension AuthStateTypeX on AuthState {
  AuthStateType get type {
    if (this is _Initial) {
      return AuthStateType.initial;
    } else if (this is _Loading) {
      return AuthStateType.loading;
    } else if (this is _Authenticated) {
      return AuthStateType.authenticated;
    } else if (this is _Unauthenticated) {
      return AuthStateType.unauthenticated;
    } else if (this is _Error) {
      return AuthStateType.error;
    } else if (this is _OtpSent) {
      return AuthStateType.otpSent;
    } else if (this is _OtpVerified) {
      return AuthStateType.otpVerified;
    }
    throw Exception('Unknown AuthState type');
  }
}
