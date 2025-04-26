import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:hui_application/core/validators/validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveIntlPhoneField extends StatefulWidget {
  final String formControlName;
  final String labelText;
  final String initialCountryCode;
  final TextEditingController? controller;
  final Map<String, String Function(Object)>? validationMessages;

  const ReactiveIntlPhoneField({
    super.key,
    required this.formControlName,
    required this.labelText,
    this.initialCountryCode = 'VN',
    this.validationMessages,
    this.controller,
  });

  @override
  State<ReactiveIntlPhoneField> createState() => ReactiveIntlPhoneFieldState();
}

class ReactiveIntlPhoneFieldState extends State<ReactiveIntlPhoneField> {
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      setState(() {
        phoneNumber!.number = widget.controller?.text.trim() ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<String, String>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      showErrors: (control) => control.invalid && control.touched,
      builder: (field) {
        final control = field.control;
        control.value = widget.controller?.text;
        if (control.asyncValidators.isEmpty) {
          final defaultCountry = CountryManager().countries.firstWhere(
            (country) => country.countryCode == 'VN',
            orElse: () => CountryManager().countries.first,
          );
          phoneNumber = PhoneNumber(
            number: '',
            countryCode: '+${defaultCountry.phoneCode}',
            countryISOCode: defaultCountry.countryCode,
          );
          control.setAsyncValidators([
            DelegateAsyncValidator(makePhoneValidator(phone: phoneNumber)),
          ], autoValidate: true);
        }
        return IntlPhoneField(
          disableLengthCheck: true,
          controller: widget.controller,
          enabled: !control.disabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
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
          onChanged: (phone) {
            // Handle phone number change
            field.didChange(phone.completeNumber);
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
        final getMessage = widget.validationMessages?[errorKey];
        if (getMessage != null) {
          return getMessage(control.errors[errorKey]!);
        }
      }
      return 'Invalid phone number';
    }
    return null;
  }
}
