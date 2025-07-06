import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/features/groups/providers/group_provider.dart';
import 'package:hui_application/features/groups/providers/group_state.dart';
import 'package:hui_application/features/groups/models/group.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final groupState = ref.watch(groupNotifierProvider);
    final groups = groupState.groups ?? [];
    final isLoading = groupState.type == GroupStateType.loading;
    final theme = Theme.of(context);

    // Demo data cho thống kê
    final totalSavings = groups.fold<double>(
      0,
      (sum, group) => sum + group.amountPerCycle,
    );
    final activeGroups =
        groups.where((g) => g.status == GroupStatus.active).length;
    final completedGroups =
        groups.where((g) => g.status == GroupStatus.completed).length;

    // Demo notifications
    final List<NotificationItem> notifications = [
      NotificationItem(
        title: 'Dây hụi "Tiết kiệm tháng 12" sắp đến kỳ đóng',
        subtitle: 'Hạn chót: 25/12/2024',
        icon: Icons.schedule,
        type: NotificationType.warning,
      ),
      NotificationItem(
        title: 'Chúc mừng! Bạn đã tham gia nhóm "Họp mặt cuối năm"',
        subtitle: 'Vừa xong',
        icon: Icons.celebration,
        type: NotificationType.success,
      ),
      NotificationItem(
        title: 'Nhóm "Mua sắm Tết" đã hoàn thành',
        subtitle: 'Tổng tiết kiệm: 50,000,000 VND',
        icon: Icons.check_circle,
        type: NotificationType.info,
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(groupNotifierProvider.notifier).fetchGroups();
        },
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.surface,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  l10n.home,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary.withAlpha(10),
                        theme.colorScheme.primary.withAlpha(5),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome Card với thống kê
                  _buildWelcomeCard(context, groups.length, totalSavings),
                  const SizedBox(height: 24),

                  // Quick Stats
                  _buildQuickStats(
                    context,
                    activeGroups,
                    completedGroups,
                    groups.length,
                  ),
                  const SizedBox(height: 24),

                  // Groups Section
                  _buildGroupsSection(context, groups, isLoading),
                  const SizedBox(height: 24),

                  // Notifications Section
                  _buildNotificationsSection(context, notifications),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(
    BuildContext context,
    int groupCount,
    double totalSavings,
  ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(80),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.savings, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context)!.get_start,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quản lý tài chính thông minh',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withAlpha(90),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatItem(
                  context,
                  groupCount.toString(),
                  S.of(context)!.groups,
                  Icons.group,
                ),
                const SizedBox(width: 24),
                _buildStatItem(
                  context,
                  totalSavings.toStringAsFixed(0),
                  'Tổng tiết kiệm',
                  Icons.account_balance_wallet,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withAlpha(80), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withAlpha(80),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(
    BuildContext context,
    int activeGroups,
    int completedGroups,
    int totalGroups,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            activeGroups.toString(),
            'Đang hoạt động',
            Icons.play_circle_filled,
            theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            completedGroups.toString(),
            'Đã hoàn thành',
            Icons.check_circle,
            theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            totalGroups.toString(),
            'Tổng cộng',
            Icons.folder,
            theme.colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(20), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsSection(
    BuildContext context,
    List<Group> groups,
    bool isLoading,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context)!.hui_fund,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to groups list
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              label: const Text('Xem tất cả'),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (groups.isEmpty)
          _buildEmptyGroupsCard(context)
        else
          _buildGroupsList(context, groups.take(3).toList()),
      ],
    );
  }

  Widget _buildEmptyGroupsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.add_circle_outline,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context)!.no_groups_yet,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context)!.create_first_group_description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to create group
            },
            icon: const Icon(Icons.add),
            label: Text(S.of(context)!.create_new_group),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsList(BuildContext context, List<Group> groups) {
    return Column(
      children: groups.map((group) => _buildGroupCard(context, group)).toList(),
    );
  }

  Widget _buildGroupCard(BuildContext context, Group group) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getStatusColor(group.status).withAlpha(10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getStatusIcon(group.status),
            color: _getStatusColor(group.status),
            size: 24,
          ),
        ),
        title: Text(
          group.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${group.amountPerCycle.toStringAsFixed(0)} VND / ${_getCycleUnitText(group.cycleUnit)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(group.status).withAlpha(10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getStatusText(group.status),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _getStatusColor(group.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        onTap: () {
          // TODO: Navigate to group details
        },
      ),
    );
  }

  Widget _buildNotificationsSection(
    BuildContext context,
    List<NotificationItem> notifications,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context)!.notifications,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        if (notifications.isEmpty)
          _buildEmptyNotificationsCard(context)
        else
          Column(
            children:
                notifications
                    .map(
                      (notification) =>
                          _buildNotificationCard(context, notification),
                    )
                    .toList(),
          ),
      ],
    );
  }

  Widget _buildEmptyNotificationsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_none,
            color: theme.colorScheme.onSurfaceVariant,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Không có thông báo mới',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificationItem notification,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getNotificationColor(notification.type).withAlpha(20),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getNotificationColor(notification.type).withAlpha(10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              notification.icon,
              color: _getNotificationColor(notification.type),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(GroupStatus status) {
    switch (status) {
      case GroupStatus.active:
        return Colors.green;
      case GroupStatus.inactive:
        return Colors.orange;
      case GroupStatus.completed:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon(GroupStatus status) {
    switch (status) {
      case GroupStatus.active:
        return Icons.play_circle_filled;
      case GroupStatus.inactive:
        return Icons.pause_circle_filled;
      case GroupStatus.completed:
        return Icons.check_circle;
    }
  }

  String _getStatusText(GroupStatus status) {
    switch (status) {
      case GroupStatus.active:
        return 'Đang hoạt động';
      case GroupStatus.inactive:
        return 'Chưa bắt đầu';
      case GroupStatus.completed:
        return 'Đã hoàn thành';
    }
  }

  String _getCycleUnitText(CycleUnit unit) {
    switch (unit) {
      case CycleUnit.day:
        return 'ngày';
      case CycleUnit.week:
        return 'tuần';
      case CycleUnit.month:
        return 'tháng';
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }
}

// Helper classes for notifications
enum NotificationType { success, warning, info }

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
  });
}
