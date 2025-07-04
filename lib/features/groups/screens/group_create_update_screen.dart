import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/forms/value_accessors/currency_double_accessor.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/features/groups/providers/group_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/widgets/app_reactive_text_field.dart';
import 'package:hui_application/widgets/cycle_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GroupCreateUpdateScreen extends ConsumerStatefulWidget {
  const GroupCreateUpdateScreen({super.key});

  @override
  ConsumerState<GroupCreateUpdateScreen> createState() =>
      _GroupCreateUpdateScreenState();
}

class _GroupCreateUpdateScreenState
    extends ConsumerState<GroupCreateUpdateScreen> {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'description': FormControl<String>(),
    'amountPerCycle': FormControl<double>(validators: [Validators.required]),
    'totalCycles': FormControl<int>(
      validators: [Validators.required, Validators.number()],
    ),
    'cycleDuration': FormControl<int>(
      validators: [Validators.required, Validators.number()],
    ),
    'cycleUnit': FormControl<String>(validators: [Validators.required]),
    'cycleTime': FormControl<String>(validators: [Validators.required]),
    'startDate': FormControl<DateTime>(
      value: DateTime.now().add(Duration(days: 1)),
    ),
    'maxMembers': FormControl<int>(
      validators: [Validators.number(), Validators.required],
    ),
    'isPrivate': FormControl<bool>(value: false),
    'password': FormControl<String>(),
    'autoStart': FormControl<bool>(value: false),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // Handle the case when there is no previous screen
              // For example, you can show a confirmation dialog or navigate to a different screen
              context.go('/groups');
            }
          },
        ),
        title: Text(S.of(context)!.create_hui_fund),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              // Handle save action
              try {
                if (form.valid) {
                  // Perform save operation
                  // You can access the form values using form.value
                  final group = Group.fromForm(form.value);
                  final success = await ref
                      .read(groupNotifierProvider.notifier)
                      .createGroup(group);
                  // After saving, you can navigate back or show a success message
                  if (success) {
                    showGlobalSuccessSnackBar(
                      message: S.of(context)!.group_created_successfully,
                      duration: const Duration(seconds: 5),
                    );
                    context.pop();
                  }
                } else {
                  // Show validation errors
                  form.markAllAsTouched();
                }
              } on ApiException catch (e) {
                // Handle error
                showGlobalErrorSnackBar(
                  message: e.message.toString(),
                  duration: const Duration(seconds: 5),
                );
              }
            },
          ),
        ],
      ),
      body: ReactiveForm(
        formGroup: form,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  AppReactiveTextField<String>(
                    label: S.of(context)!.name_of_hui,
                    formControlName: 'name',
                  ),
                  const SizedBox(height: 16),
                  AppReactiveTextField<String>(
                    label: S.of(context)!.description,
                    formControlName: 'description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppReactiveTextField.currency(
                          label: S.of(context)!.amount_per_cycle,
                          formControlName: 'amountPerCycle',
                          valueAccessor: CurrencyDoubleAccessor(symbol: '₫'),
                          validationMessages: {
                            ValidationMessage.required:
                                (error) => S
                                    .of(context)!
                                    .required_error(
                                      S.of(context)!.amount_per_cycle,
                                    ),
                            ValidationMessage.number:
                                (error) => S
                                    .of(context)!
                                    .invalid_error(
                                      S.of(context)!.amount_per_cycle,
                                    ),
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppReactiveTextField<int>(
                          label: S.of(context)!.total_cycles,
                          formControlName: 'totalCycles',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validationMessages: {
                            ValidationMessage.required:
                                (error) => S
                                    .of(context)!
                                    .required_error(
                                      S.of(context)!.total_cycles,
                                    ),
                            ValidationMessage.number:
                                (error) => S
                                    .of(context)!
                                    .invalid_error(S.of(context)!.total_cycles),
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppReactiveTextField<int>(
                          label: S.of(context)!.maximum_members,
                          formControlName: 'maxMembers',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validationMessages: {
                            ValidationMessage.required:
                                (error) => S
                                    .of(context)!
                                    .required_error(
                                      S.of(context)!.maximum_members,
                                    ),
                            ValidationMessage.number:
                                (error) => S
                                    .of(context)!
                                    .invalid_error(
                                      S.of(context)!.maximum_members,
                                    ),
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CycleDurationInput(
                                label: S.of(context)!.duration_cycle,
                                formControlNameDuration: 'cycleDuration',
                                formControlNameUnit: 'cycleUnit',
                                validationMessages: {
                                  ValidationMessage.required:
                                      (error) => S
                                          .of(context)!
                                          .required_error(
                                            S.of(context)!.duration_cycle,
                                          ),
                                  ValidationMessage.number:
                                      (error) => S
                                          .of(context)!
                                          .invalid_error(
                                            S.of(context)!.duration_cycle,
                                          ),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppReactiveTextField(
                          label: S.of(context)!.start_date,
                          formControlName: 'startDate',
                          readOnly: true,
                          onTap: (control) async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: control.value as DateTime,
                              firstDate: control.value as DateTime,
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              control.value = picked;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppReactiveTextField<String>(
                          label: S.of(context)!.time_opened,
                          formControlName: 'cycleTime',
                          readOnly: true,
                          onTap: (control) async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            control.value = picked?.format(context);
                          },
                          validationMessages: {
                            ValidationMessage.required:
                                (error) => S
                                    .of(context)!
                                    .required_error(S.of(context)!.time_opened),
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ReactiveSwitchListTile.adaptive(
                          formControlName: 'isPrivate',
                          title: Text(S.of(context)!.private_group),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          onChanged: (control) {
                            // form.control('isPrivate').updateValue(value);
                            if (control.value == true) {
                              Future(() {
                                form.control('password').setValidators([
                                  Validators.required,
                                ]);
                              });
                            } else {
                              form.control('password').clearValidators();
                            }
                            form.control('password').updateValue(null);
                            form.control('password').markAsEnabled();
                          },
                        ),
                      ),
                    ],
                  ),
                  ReactiveValueListenableBuilder<bool>(
                    formControlName: 'isPrivate',
                    builder: (context, control, child) {
                      return control.value == true
                          ? Column(
                            children: [
                              const SizedBox(height: 16),
                              AppReactiveTextField<String>(
                                label: S.of(context)!.password,
                                formControlName: 'password',
                                obscureText: true,
                                validationMessages: {
                                  ValidationMessage.required:
                                      (error) => S
                                          .of(context)!
                                          .required_error(
                                            S.of(context)!.password,
                                          ),
                                },
                              ),
                            ],
                          )
                          : const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),
                  ReactiveSwitchListTile.adaptive(
                    formControlName: 'autoStart',
                    title: Text(S.of(context)!.auto_start_when_member_full),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
