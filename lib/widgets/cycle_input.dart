import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/widgets/app_reactive_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CycleDurationInput extends StatefulWidget {
  final String formControlNameDuration;
  final String formControlNameUnit;
  final Map<String, String Function(Object)>? validationMessages;
  final String label;

  const CycleDurationInput({
    super.key,
    required this.formControlNameDuration,
    required this.formControlNameUnit,
    required this.label,
    this.validationMessages,
  });

  @override
  State<CycleDurationInput> createState() => _CycleDurationInputState();
}

class _CycleDurationInputState extends State<CycleDurationInput> {
  final TextEditingController _durationController = TextEditingController();
  String _selectedUnit = 'week';
  final List<String> _units =
      CycleUnit.values.map((unit) => unit.name).toList();

  @override
  void initState() {
    super.initState();
    Future(() {
      (ReactiveForm.of(context) as FormGroup?)
          ?.control(widget.formControlNameUnit)
          .updateValue(_selectedUnit);
    });
  }

  void _showUnitPicker() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Done button
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      (ReactiveForm.of(context) as FormGroup?)
                          ?.control(widget.formControlNameUnit)
                          .updateValue(_selectedUnit);
                      Navigator.pop(context);
                    },
                    child: const Text('Done'),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: _units.indexOf(_selectedUnit),
                    ),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedUnit = _units[index];
                      });
                    },
                    children: _units.map((u) => Text(u)).toList(),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppReactiveTextField(
      label: widget.label,
      formControlName: widget.formControlNameDuration,
      controller: _durationController,
      validationMessages: widget.validationMessages,
      suffixIcon: GestureDetector(
        onTap: _showUnitPicker,
        child: SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_selectedUnit.uppercaseFirst()),
                const Icon(CupertinoIcons.chevron_up_chevron_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
