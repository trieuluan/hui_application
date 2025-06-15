import 'package:flutter/cupertino.dart';

Future<void> showCupertinoDatePickerModal({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  required void Function(DateTime date) onDateSelected,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder:
        (context) => Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: minimumDate,
                  maximumDate: maximumDate,
                  onDateTimeChanged: onDateSelected,
                ),
              ),
            ],
          ),
        ),
  );
}
