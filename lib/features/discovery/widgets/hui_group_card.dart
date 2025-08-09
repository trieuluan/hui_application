import 'package:flutter/material.dart';
import 'package:hui_application/features/discovery/models/discovery_state.dart';

class HuiGroupCard extends StatelessWidget {
  final HuiGroupPreview group;
  final VoidCallback onJoinRequest;

  const HuiGroupCard({
    super.key,
    required this.group,
    required this.onJoinRequest,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Chủ hụi: ${group.ownerName}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildPrivacyBadge(theme),
              ],
            ),

            const SizedBox(height: 16),

            // Details
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.attach_money,
                    label: 'Số tiền',
                    value: '${(group.amount / 1000000).toStringAsFixed(1)}M',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.schedule,
                    label: 'Thời gian',
                    value: '${group.duration} tháng',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.location_on,
                    label: 'Khu vực',
                    value: group.location,
                    theme: theme,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Members
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  '${group.memberCount}/${group.maxMembers} thành viên',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                _buildJoinButton(theme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyBadge(ThemeData theme) {
    Color badgeColor;
    String badgeText;
    IconData badgeIcon;

    switch (group.privacy) {
      case GroupPrivacy.public:
        badgeColor = Colors.green;
        badgeText = 'Công khai';
        badgeIcon = Icons.public;
        break;
      case GroupPrivacy.inviteOnly:
        badgeColor = Colors.orange;
        badgeText = 'Mời tham gia';
        badgeIcon = Icons.group_add;
        break;
      case GroupPrivacy.private:
        badgeColor = Colors.red;
        badgeText = 'Riêng tư';
        badgeIcon = Icons.lock;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 12, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            badgeText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinButton(ThemeData theme) {
    switch (group.joinStatus) {
      case JoinStatus.available:
        return ElevatedButton(
          onPressed: onJoinRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('Tham gia'),
        );

      case JoinStatus.requested:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Đã yêu cầu',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

      case JoinStatus.joined:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Text(
            'Đã tham gia',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

      case JoinStatus.full:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Đã đầy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
    }
  }
}
