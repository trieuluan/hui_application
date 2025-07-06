import 'package:flutter/material.dart';
import 'package:hui_application/core/utils/date_time_extension.dart';
import 'package:hui_application/core/utils/num_extension.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';

class GroupScreenOverview extends StatelessWidget {
  final Group group;

  const GroupScreenOverview({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    // Calculate progress percentage
    final progressPercentage =
        group.totalCycles > 0
            ? (group.cycleDuration / group.totalCycles * 100).clamp(0.0, 100.0)
            : 0.0;

    // Calculate remaining cycles
    final remainingCycles = group.totalCycles - group.cycleDuration;

    // Calculate estimated completion date
    final estimatedCompletionDate =
        group.startDate != null && group.status == GroupStatus.active
            ? group.startDate!.add(
              Duration(days: remainingCycles * 30),
            ) // Assuming 30 days per cycle
            : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Section
          _buildProgressCard(context, theme, l10n, progressPercentage),

          const SizedBox(height: 20),

          // Key Statistics
          _buildStatisticsGrid(context, theme, l10n, remainingCycles),

          const SizedBox(height: 20),

          // Group Details
          _buildDetailsCard(context, theme, l10n, estimatedCompletionDate),

          const SizedBox(height: 20),

          // Quick Actions
          _buildQuickActions(context, theme, l10n),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    ThemeData theme,
    S? l10n,
    double progressPercentage,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.primaryContainer.withAlpha(80),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timeline,
                color: theme.colorScheme.onPrimaryContainer,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Progress',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${group.cycleDuration}/${group.totalCycles}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cycles completed',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer.withAlpha(
                          80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${progressPercentage.toInt()}%',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Completed',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progressPercentage / 100,
            backgroundColor: theme.colorScheme.onPrimaryContainer.withAlpha(20),
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.onPrimaryContainer,
            ),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(
    BuildContext context,
    ThemeData theme,
    S? l10n,
    int remainingCycles,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          context,
          theme,
          Icons.attach_money,
          group.amountPerCycle.toVNDWithSymbol,
          l10n?.amount_per_cycle ?? 'Amount per cycle',
          theme.colorScheme.primary,
        ),
        _buildStatCard(
          context,
          theme,
          Icons.people,
          '${group.totalCycles}',
          l10n?.total_cycles ?? 'Total cycles',
          theme.colorScheme.secondary,
        ),
        _buildStatCard(
          context,
          theme,
          Icons.schedule,
          group.startDate?.format('dd/MM/yyyy') ?? 'N/A',
          l10n?.open_date ?? 'Open date',
          theme.colorScheme.tertiary,
        ),
        _buildStatCard(
          context,
          theme,
          Icons.timer,
          remainingCycles.toString(),
          'Remaining',
          theme.colorScheme.error,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    ThemeData theme,
    S? l10n,
    DateTime? estimatedCompletionDate,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Group Details',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            theme,
            Icons.calendar_today,
            l10n?.open_date ?? 'Open date',
            group.startDate?.format('dd/MM/yyyy') ?? 'Chưa xác định',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            theme,
            Icons.flag,
            'Status',
            group.status == GroupStatus.active
                ? 'Đang hoạt động'
                : 'Chưa bắt đầu',
            valueColor:
                group.status == GroupStatus.active
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
          ),
          if (estimatedCompletionDate != null) ...[
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              theme,
              Icons.event_available,
              'Dự kiến hoàn thành',
              estimatedCompletionDate.format('dd/MM/yyyy'),
              valueColor: theme.colorScheme.secondary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme, S? l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                'Quick Actions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  theme,
                  Icons.add,
                  'Join Auction',
                  () {
                    // TODO: Navigate to auction
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context,
                  theme,
                  Icons.people,
                  'View Members',
                  () {
                    // TODO: Navigate to members
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.primary.withAlpha(20),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
