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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/groups');
            }
          },
        ),
        title: Text(S.of(context)!.create_hui_fund),
        elevation: 0.5,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: theme.colorScheme.surfaceContainerLowest,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 22,
                      ),
                      child: ReactiveForm(
                        formGroup: form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context)!.group_information,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 18),
                            AppReactiveTextField<String>(
                              label: S.of(context)!.name_of_hui,
                              formControlName: 'name',
                              prefixIcon: const Icon(Icons.group),
                            ),
                            const SizedBox(height: 16),
                            AppReactiveTextField<String>(
                              label: S.of(context)!.description,
                              formControlName: 'description',
                              maxLines: 3,
                              prefixIcon: const Icon(
                                Icons.description_outlined,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              S.of(context)!.fund_details,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: AppReactiveTextField.currency(
                                    label: S.of(context)!.amount_per_cycle,
                                    formControlName: 'amountPerCycle',
                                    valueAccessor: CurrencyDoubleAccessor(
                                      symbol: '₫',
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.payments_outlined,
                                    ),
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
                                    prefixIcon: const Icon(Icons.repeat),
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
                                              .invalid_error(
                                                S.of(context)!.total_cycles,
                                              ),
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: AppReactiveTextField<int>(
                                    label: S.of(context)!.maximum_members,
                                    formControlName: 'maxMembers',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    prefixIcon: const Icon(
                                      Icons.people_alt_outlined,
                                    ),
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
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: AppReactiveTextField(
                                    label: S.of(context)!.start_date,
                                    formControlName: 'startDate',
                                    readOnly: true,
                                    prefixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                    ),
                                    onTap: (control) async {
                                      final DateTime?
                                      picked = await showDatePicker(
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
                                    prefixIcon: const Icon(Icons.access_time),
                                    onTap: (control) async {
                                      final TimeOfDay? picked =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                      control.value = picked?.format(context);
                                    },
                                    validationMessages: {
                                      ValidationMessage.required:
                                          (error) => S
                                              .of(context)!
                                              .required_error(
                                                S.of(context)!.time_opened,
                                              ),
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              S.of(context)!.privacy_and_automation,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ReactiveSwitchListTile.adaptive(
                              formControlName: 'isPrivate',
                              title: Text(S.of(context)!.private_group),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              onChanged: (control) {
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
                            ReactiveValueListenableBuilder<bool>(
                              formControlName: 'isPrivate',
                              builder: (context, control, child) {
                                return control.value == true
                                    ? Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        AppReactiveTextField<String>(
                                          label: S.of(context)!.password,
                                          formControlName: 'password',
                                          obscureText: true,
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                          ),
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
                            const SizedBox(height: 10),
                            ReactiveSwitchListTile.adaptive(
                              formControlName: 'autoStart',
                              title: Text(
                                S.of(context)!.auto_start_when_member_full,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save_alt_rounded),
              label: Text(
                S.of(context)!.save,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
              onPressed: () async {
                try {
                  if (form.valid) {
                    final group = Group.fromForm(form.value);
                    final success = await ref
                        .read(groupNotifierProvider.notifier)
                        .createGroup(group);
                    if (success) {
                      if (context.mounted) {
                        showGlobalSuccessSnackBar(
                          message: S.of(context)!.group_created_successfully,
                          duration: const Duration(seconds: 5),
                        );
                        Navigator.of(context).pop();
                      }
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                } on ApiException catch (e) {
                  if (context.mounted) {
                    showGlobalErrorSnackBar(
                      message: e.message.toString(),
                      duration: const Duration(seconds: 5),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
