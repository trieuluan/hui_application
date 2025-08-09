class Endpoints {
  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/auth/logout';
  static const String checkAvailability = '/auth/check-availability';
  static const String checkPassword = '/auth/check-password';
  static const String checkPasswordStrength = '/auth/check-password-strength';
  static const String passwordConfig = '/auth/password-config';

  // User
  static const String getProfile = '/user/profile';
  static const String updateProfile = '/user/update';

  // Group
  static const String getGroups = '/groups';
  static const String joinGroup = '/groups/join';
  static const String leaveGroup = '/groups/leave';
}
