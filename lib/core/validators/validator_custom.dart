import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:hui_application/widgets/reactive_intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

AsyncValidatorFunction makePhoneValidator({String errorKey = 'invalidPhone'}) {
  return (AbstractControl<dynamic> control) async {
    final phone = control.value as ParsedPhoneData?;

    try {
      final parsed = await parse(phone!.completeNumber);
      if (parsed['type'] != 'mobile') {
        return {'invalidPhone': 'Please enter a valid mobile number'};
      }
    } catch (_) {
      return {'invalidPhone': 'Please enter a valid phone number'};
    }
    return null; // No errors
  };
}

ValidatorFunction makeConfirmValidator(String fieldToMatch) {
  return (AbstractControl<dynamic> control) {
    final formGroup = control.parent as FormGroup?;
    if (formGroup == null) return null;

    final password = formGroup.control(fieldToMatch).value as String?;
    final confirmPassword = control.value as String?;

    if (password != confirmPassword) {
      return {'mismatch': 'Passwords do not match'};
    }

    return null; // No errors
  };
}

final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email can\'t be empty';
  } else if (!emailRegex.hasMatch(value.trim())) {
    return 'Invalid email format';
  }
  return null;
}
