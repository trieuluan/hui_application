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
        await ref.read(groupNotiferProvider.notifier).fetchGroups();
      } catch (e) {
        showGlobalErrorSnackBar(
          message: ref.read(groupNotiferProvider).errorMessage!,
        );
      }
    });
    // Fetch groups data from the service
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupNotiferProvider).groups;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hụi Fund'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       context.push('/group/create');
        //     },
        //   ),
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: groups?.length ?? 0,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final group = groups![index];
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
                                  .read(groupNotiferProvider.notifier)
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
                                        .read(groupNotiferProvider)
                                        .errorMessage!,
                              );
                            }
                          },
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onError,
                          icon: Icons.delete,
                          label: 'Delete',
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
                          label: 'Edit',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      group.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${group.createdAt?.format('dd MMM yyyy')} - ${group.code}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: CupertinoColors.systemGrey,
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
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
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
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  // Handle add group action
                  context.push('/groups/create');
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
