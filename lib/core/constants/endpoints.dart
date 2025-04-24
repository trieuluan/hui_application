class Endpoints {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String checkAvailability = '/auth/check-availability';

  // User
  static const String getProfile = '/user/profile';
  static const String updateProfile = '/user/update';

  // Group
  static const String getGroups = '/groups';
  static const String joinGroup = '/groups/join';
  static const String leaveGroup = '/groups/leave';
}
