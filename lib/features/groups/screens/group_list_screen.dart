import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/utils/date_time_extension.dart';
import 'package:hui_application/core/utils/num_extension.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/core/utils/string_extension.dart';
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
        return Colors.blue[200]!;
      case 'Done':
        return Colors.orange;
      case 'In Progress':
        return Colors.green[200]!;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch groups data when the screen is initialized
    _fetchGroups();
  }

  _fetchGroups() async {
    // Simulate a network call
    Future(() async {
      try {
        await ref.read(groupNotifierProvider.notifier).fetchGroups();
      } catch (e) {
        showGlobalErrorSnackBar(
          message: ref.read(groupNotifierProvider).errorMessage!,
        );
      }
    });
    // Fetch groups data from the service
  }

  Widget _buildEmptyState() {
    final l10n = S.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.group_solid,
                size: 60,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              l10n.no_groups_yet,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              l10n.create_first_group_description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Create group button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/groups/create');
                },
                icon: const Icon(Icons.add, size: 20),
                label: Text(
                  l10n.create_new_group,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Secondary action
            TextButton.icon(
              onPressed: () {
                // Có thể thêm action như refresh hoặc help
                _fetchGroups();
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(l10n.refresh, style: const TextStyle(fontSize: 14)),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupState = ref.watch(groupNotifierProvider);
    final groups = groupState.groups;
    final isLoading = groupState.type == GroupStateType.loading;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.hui_fund),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/groups/create');
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : (groups == null || groups.isEmpty)
              ? _buildEmptyState()
              : Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groups.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return Slidable(
                      key: Key(group.id ?? index.toString()),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.5,
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              // Handle delete action
                              try {
                                final result = await ref
                                    .read(groupNotifierProvider.notifier)
                                    .deleteGroup(group.id ?? '');
                                if (result['success'] == true) {
                                  showGlobalSuccessSnackBar(
                                    message: result['message'],
                                  );
                                } else {
                                  showGlobalErrorSnackBar(
                                    message: result['message'],
                                  );
                                }
                              } catch (e) {
                                showGlobalErrorSnackBar(
                                  message:
                                      ref
                                          .read(groupNotifierProvider)
                                          .errorMessage!,
                                );
                              }
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                            icon: Icons.delete,
                            label: S.of(context)!.delete,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              // Handle edit action
                              context.push('/groups/${group.id}/edit');
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            icon: Icons.edit,
                            label: S.of(context)!.edit,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.push('/groups/${group.id}');
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${group.createdAt?.format('dd MMM yyyy')} - ${group.code}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _statusColor(group.status.name),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        group.status.name.capitalize(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      group.amountPerCycle.toVNDWithSymbol,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
