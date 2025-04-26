import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInputField extends StatefulWidget {
  final Function(PhoneNumber phone)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Future<String?> Function(PhoneNumber?)? validator;
  final bool enabled;

  const PhoneInputField({
    super.key,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.validator,
    this.enabled = true,
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
        _errorText = 'Phone number cannot be empty';
      }
      final parsed = await parse(phone.completeNumber);
      final isValid = parsed['type'] != null;

      setState(() {
        _errorText = isValid ? null : 'Invalid phone number';
      });
    } catch (e) {
      setState(() {
        _errorText = 'Invalid phone number';
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
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: const OutlineInputBorder(),
        errorText: _errorText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
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
