import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CupertinoReactiveTextField extends StatelessWidget {
  final String formControlName;
  final String? placeholder;
  final Map<String, String Function(Object)>? validationMessages;

  const CupertinoReactiveTextField({
    super.key,
    required this.formControlName,
    this.placeholder,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      builder: (field) {
        final controller = TextEditingController(text: field.value as String?);
        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoTextField(
              placeholder: placeholder,
              controller: controller,
              onChanged: field.didChange,
              onSubmitted: field.didChange,
              onTap: field.control.markAsTouched,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
            ),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 6),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
