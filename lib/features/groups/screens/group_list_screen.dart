import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/utils/date_time_extension.dart';
import 'package:hui_application/core/utils/num_extension.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/core/utils/string_extension.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/models/users.dart';
import 'package:hui_application/features/groups/providers/group_provider.dart';
import 'package:hui_application/features/groups/providers/group_state.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';

class GroupListScreen extends ConsumerStatefulWidget {
  const GroupListScreen({super.key});

  @override
  ConsumerState<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends ConsumerState<GroupListScreen> {
  Color _statusColor(String status) {
    switch (status) {
      case 'Waiting':
        return Colors.blue[400]!;
      case 'Done':
        return Colors.orange;
      case 'In Progress':
        return Colors.green[400]!;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  _fetchGroups() async {
    Future(() async {
      try {
        await ref.read(groupNotifierProvider.notifier).fetchGroups();
      } catch (e) {
        showGlobalErrorSnackBar(
          message: ref.read(groupNotifierProvider).errorMessage!,
        );
      }
    });
  }

  Widget _buildEmptyState() {
    final l10n = S.of(context)!;
    final theme = Theme.of(context);
    final isOwner = _canCreateGroups();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                isOwner ? CupertinoIcons.group_solid : Icons.group_outlined,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              isOwner ? 'Chưa có hụi nào' : 'Chưa tham gia hụi nào',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              isOwner
                  ? 'Tạo hụi đầu tiên để bắt đầu quản lý nhóm hụi của bạn'
                  : 'Tham gia hụi từ trang Khám phá để bắt đầu',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            if (isOwner)
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/groups/create');
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text(
                  'Tạo hụi mới',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to discovery tab
                  context.go('/discovery');
                },
                icon: const Icon(Icons.explore, size: 20),
                label: const Text(
                  'Khám phá hụi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
              ),
            const SizedBox(height: 18),
            TextButton.icon(
              onPressed: _fetchGroups,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(l10n.refresh),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canCreateGroups() {
    final user = ref.read(authNotifierProvider).user;
    if (user == null) return false;
    return user.userPermissions.canCreateGroup;
  }

  @override
  Widget build(BuildContext context) {
    final groupState = ref.watch(groupNotifierProvider);
    final groups = groupState.groups;
    final isLoading = groupState.type == GroupStateType.loading;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_canCreateGroups() ? 'Quản lý hụi' : 'Hụi của tôi'),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: theme.colorScheme.surface,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchGroups),
        ],
      ),
      floatingActionButton:
          _canCreateGroups()
              ? FloatingActionButton(
                onPressed: () => context.push('/groups/create'),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.add),
              )
              : null,
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : (groups == null || groups.isEmpty)
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return GroupCard(
                    group: group,
                    statusColor: _statusColor(group.status.name),
                    onTap: () => context.push('/groups/${group.id}'),
                    onEdit: () => context.push('/groups/${group.id}/edit'),
                    onDelete: () async {
                      try {
                        final result = await ref
                            .read(groupNotifierProvider.notifier)
                            .deleteGroup(group.id ?? '');
                        if (result['success'] == true) {
                          showGlobalSuccessSnackBar(message: result['message']);
                        } else {
                          showGlobalErrorSnackBar(message: result['message']);
                        }
                      } catch (e) {
                        showGlobalErrorSnackBar(
                          message:
                              ref.read(groupNotifierProvider).errorMessage!,
                        );
                      }
                    },
                  );
                },
              ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Group group;
  final Color statusColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GroupCard({
    super.key,
    required this.group,
    required this.statusColor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: theme.colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.12,
                ),
                radius: 28,
                child: Icon(Icons.groups, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${group.createdAt?.format('dd/MM/yyyy')} • ${group.code}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            group.status.name.capitalize(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          group.amountPerCycle.toVNDWithSymbol,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(S.of(context)!.edit),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 18,
                              color: theme.colorScheme.error,
                            ),
                            const SizedBox(width: 8),
                            Text(S.of(context)!.delete),
                          ],
                        ),
                      ),
                    ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
