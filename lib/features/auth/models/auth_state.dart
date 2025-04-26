import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default('') String emailOrPhone,
    @Default(false) bool isLoggedIn,
    @Default('') String token,
    @Default({}) Map<String, dynamic> user,
  }) = _AuthState;
}
