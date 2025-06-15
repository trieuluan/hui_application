import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';

bool requireAuth(Ref ref) {
  final authState = ref.read(authNotifierProvider);
  return authState.type == AuthStateType.authenticated;
}

bool guestOnly(Ref ref) {
  final authState = ref.read(authNotifierProvider);
  return authState.type == AuthStateType.unauthenticated ||
      authState.type == AuthStateType.otpSent ||
      authState.type == AuthStateType.otpVerified;
}
