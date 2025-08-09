import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/utils/cupertino_date_picker_modal.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_text_field.dart';

class ProfileSetupStep extends ConsumerWidget {
  const ProfileSetupStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFlowState = ref.watch(authFlowNotifierProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Profile setup icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Thông tin cá nhân',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Hoàn thiện thông tin để tạo tài khoản',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Role Selection
          _buildRoleSelection(context, ref, theme),
          const SizedBox(height: 24),

          // Full Name
          AppTextField(
            label: 'Họ và tên',
            onChanged: (value) {
              ref.read(authFlowNotifierProvider.notifier).setFullName(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập họ tên';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Date of Birth
          _buildDateOfBirthField(context, ref, theme),
          const SizedBox(height: 16),

          // Gender
          _buildGenderField(context, ref, theme),
          const SizedBox(height: 16),

          // Address
          AppTextField(
            label: 'Địa chỉ',
            onChanged: (value) {
              ref.read(authFlowNotifierProvider.notifier).setAddress(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập địa chỉ';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: AnimatedCircleButton(
              isLoading: authFlowState.isLoading,
              onPressed:
                  () =>
                      ref
                          .read(authFlowNotifierProvider.notifier)
                          .handleProfileSetup(),
              title: 'Tiếp tục',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelection(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) {
    final selectedRole = ref.watch(authFlowNotifierProvider).selectedRole;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vai trò',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildRoleOption(
                context,
                ref,
                theme,
                'chu_hui',
                'Chủ hụi',
                'Tạo và quản lý các nhóm hụi',
                Icons.group,
                selectedRole == 'chu_hui',
              ),
              Divider(
                height: 1,
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
              _buildRoleOption(
                context,
                ref,
                theme,
                'hui_vien',
                'Hụi viên',
                'Tham gia các nhóm hụi',
                Icons.person,
                selectedRole == 'hui_vien',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleOption(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    String role,
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        ref.read(authFlowNotifierProvider.notifier).setSelectedRole(role);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? theme.colorScheme.primaryContainer
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 20,
                color:
                    isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected
                              ? theme.colorScheme.onPrimaryContainer
                              : theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          isSelected
                              ? theme.colorScheme.onPrimaryContainer.withValues(
                                alpha: 0.7,
                              )
                              : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) {
    final dateOfBirth = ref.watch(authFlowNotifierProvider).dateOfBirth;

    return InkWell(
      onTap: () {
        showCupertinoDatePickerModal(
          context: context,
          initialDate: DateTime.now().subtract(
            const Duration(days: 6570),
          ), // 18 years ago
          minimumDate: DateTime.now().subtract(
            const Duration(days: 36500),
          ), // 100 years ago
          maximumDate: DateTime.now().subtract(
            const Duration(days: 6570),
          ), // 18 years ago
          onDateSelected: (selectedDate) {
            final formattedDate =
                '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
            ref
                .read(authFlowNotifierProvider.notifier)
                .setDateOfBirth(formattedDate);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                dateOfBirth ?? 'Chọn ngày sinh',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      dateOfBirth != null
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderField(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) {
    final selectedGender = ref.watch(authFlowNotifierProvider).gender;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGender,
                hint: Text(
                  'Chọn giới tính',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Nam')),
                  DropdownMenuItem(value: 'female', child: Text('Nữ')),
                  DropdownMenuItem(value: 'other', child: Text('Khác')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref
                        .read(authFlowNotifierProvider.notifier)
                        .setGender(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
