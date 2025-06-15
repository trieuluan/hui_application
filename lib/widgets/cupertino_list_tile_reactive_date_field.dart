import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hui_application/core/utils/cupertino_date_picker_modal.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CupertinoListTileReactiveDateField extends StatelessWidget {
  final String formControlName;
  final String label;
  final String placeholder;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Map<String, String Function(Object)>? validationMessages;

  const CupertinoListTileReactiveDateField({
    super.key,
    required this.formControlName,
    required this.label,
    required this.placeholder,
    this.minimumDate,
    this.maximumDate,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<DateTime, DateTime>(
      formControlName: 'date',
      validationMessages: validationMessages,
      builder: (field) {
        final value = field.value;
        final hasError = field.control.invalid && field.control.touched;
        final displayText =
            value != null
                ? '${value.day}/${value.month}/${value.year}'
                : placeholder;

        return CupertinoListTile.notched(
          onTap: () {
            field.control.markAsTouched();
            showCupertinoDatePickerModal(
              context: context,
              initialDate: DateTime.now(),
              onDateSelected: (date) {
                field.didChange(date);
              },
            );
          },
          padding: EdgeInsets.symmetric(horizontal: 12),
          title: Text(label),
          additionalInfo: Text(
            hasError ? (field.errorText ?? '') : displayText,
            style: TextStyle(
              fontSize: 15,
              color:
                  hasError ? CupertinoColors.systemRed : CupertinoColors.black,
            ),
          ),
          trailing: Icon(
            Icons.calendar_today,
            color: hasError ? CupertinoColors.systemRed : Colors.black,
          ),
        );
      },
    );
  }
}
