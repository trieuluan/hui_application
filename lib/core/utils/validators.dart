final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email can\'t be empty';
  } else if (!emailRegex.hasMatch(value.trim())) {
    return 'Invalid email format';
  }
  return null;
}
