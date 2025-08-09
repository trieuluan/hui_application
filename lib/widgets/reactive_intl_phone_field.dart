import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Model để chứa data từ parse function
class ParsedPhoneData {
  final String e164;
  final String nationalNumber;
  final String countryCode;
  final String regionCode;
  final String completeNumber;
  final String number;

  ParsedPhoneData({
    required this.e164,
    required this.nationalNumber,
    required this.countryCode,
    required this.regionCode,
    required this.completeNumber,
    required this.number,
  });

  @override
  String toString() {
    return 'ParsedPhoneData(e164: $e164, nationalNumber: $nationalNumber, countryCode: $countryCode, regionCode: $regionCode, completeNumber: $completeNumber, number: $number)';
  }
}

class ReactiveIntlPhoneField extends StatefulWidget {
  final String formControlName;
  final String labelText;
  final String initialCountryCode;
  final Map<String, String Function(Object)>? validationMessages;

  const ReactiveIntlPhoneField({
    super.key,
    required this.formControlName,
    required this.labelText,
    this.initialCountryCode = 'VN',
    this.validationMessages,
  });

  @override
  State<ReactiveIntlPhoneField> createState() => ReactiveIntlPhoneFieldState();
}

class ReactiveIntlPhoneFieldState extends State<ReactiveIntlPhoneField> {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<ParsedPhoneData, ParsedPhoneData>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      showErrors: (control) => control.invalid && control.touched,
      builder: (field) {
        final control = field.control;

        return IntlPhoneField(
          initialValue: control.value?.completeNumber,
          disableLengthCheck: true,
          enabled: !control.disabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            errorText: _getErrorText(control),
          ),
          initialCountryCode: widget.initialCountryCode,
          onChanged: (phone) async {
            // Handle phone number change
            try {
              final parsed = await parse(phone.completeNumber);
              field.didChange(
                ParsedPhoneData(
                  e164: parsed['e164'],
                  nationalNumber: parsed['national_number'],
                  countryCode: parsed['country_code'],
                  regionCode: parsed['region_code'],
                  completeNumber: phone.completeNumber,
                  number: phone.number,
                ),
              );
              // control.updateValueAndValidity();
            } catch (e) {
              field.didChange(
                ParsedPhoneData(
                  e164: '',
                  nationalNumber: '',
                  countryCode: '',
                  regionCode: '',
                  completeNumber: phone.completeNumber,
                  number: phone.number,
                ),
              );
            }
            control.markAsTouched();
            control.updateValueAndValidity();
          },
        );
      },
    );
  }

  String? _getErrorText(AbstractControl? control) {
    if (control!.invalid && control.touched) {
      for (final errorKey in control.errors.keys) {
        return widget.validationMessages?[errorKey] != null
            ? widget.validationMessages![errorKey]!(errorKey)
            : control.errors[errorKey] as String?;
      }
      return 'Invalid phone number';
    }
    return null;
  }
}
