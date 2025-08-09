import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInputField extends StatefulWidget {
  final Function(PhoneNumber phone)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Future<String?> Function(PhoneNumber?)? validator;
  final bool enabled;
  final String? labelText;

  const PhoneInputField({
    super.key,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.validator,
    this.enabled = true,
    this.labelText,
  });

  @override
  State<PhoneInputField> createState() => PhoneInputFieldState();
}

class PhoneInputFieldState extends State<PhoneInputField> {
  String? _errorText;
  String? countryCode = '';
  String? countryISOCode = '';
  late TextEditingController _internalController;
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    init();
    _internalController = widget.controller ?? TextEditingController();
    _internalFocusNode = widget.focusNode ?? FocusNode();

    final defaultCountry = CountryManager().countries.firstWhere(
      (country) => country.countryCode == 'VN',
      orElse: () => CountryManager().countries.first,
    );
    countryCode = '+${defaultCountry.phoneCode}';
    countryISOCode = defaultCountry.countryCode;
  }

  Future<String?> validatePhone(PhoneNumber? phone) async {
    try {
      if (phone!.completeNumber.isEmpty) {
        setState(() {
          _errorText = S.of(context)!.phone_number_cannot_be_empty;
        });
        return _errorText;
      }

      // Check if phone number contains only digits and valid characters
      final phoneNumberOnly = phone.completeNumber.replaceAll(
        RegExp(r'[^\d+]'),
        '',
      );
      if (phoneNumberOnly != phone.completeNumber) {
        setState(() {
          _errorText = S.of(context)!.phone_number_error;
        });
        return _errorText;
      }

      final parsed = await parse(phone.completeNumber);
      final isValid = parsed['type'] != null && parsed['type'] == 'mobile';

      setState(() {
        _errorText = isValid ? null : S.of(context)!.phone_number_error;
      });
    } catch (e) {
      setState(() {
        _errorText = S.of(context)!.phone_number_error;
      });
    }
    return _errorText;
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: 'VN',
      controller: _internalController,
      enabled: widget.enabled,
      focusNode: _internalFocusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      disableLengthCheck: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\(\)\s]')),
      ],
      decoration: InputDecoration(
        labelText: widget.labelText ?? S.of(context)!.phone_placeholder,
        errorText: _errorText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: widget.onChanged,
      validator: validatePhone,
      onCountryChanged: (country) {
        setState(() {
          countryCode = country.dialCode;
          countryISOCode = country.code;
        });
      },
    );
  }
}
