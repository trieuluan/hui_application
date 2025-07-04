import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/features/groups/providers/group_provider.dart';
import 'package:hui_application/features/groups/screens/group_screen_details/overview.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final String id;
  const GroupScreen({super.key, required this.id});

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  Group? group;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedTab =
        Uri.parse(location).queryParameters['tab'] ?? 'overview';
    final groupAsync = ref.watch(groupDetailProvider(widget.id));

    // Load group data when the screen is built
    return groupAsync.when(
      data:
          (groupData) => Scaffold(
            appBar: AppBar(
              title: const Text('Hui Fund'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
                IconButton(
                  onPressed: () {
                    // Handle add group action
                  },
                  icon: const Icon(CupertinoIcons.slider_horizontal_3),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CupertinoSlidingSegmentedControl<String>(
                        groupValue: selectedTab,
                        children: const {
                          'overview': Text('Overview'),
                          'members': Text('Members'),
                          'invoice': Text('Invoices'),
                        },
                        onValueChanged: (value) {
                          if (value != null) {
                            context.go('/groups/${widget.id}?tab=$value');
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: switch (selectedTab) {
                      'overview' => GroupScreenOverview(group: groupData!),
                      'members' => const Center(child: Text('Members')),
                      'invoice' => const Center(child: Text('Invoices')),
                      _ => const Center(child: Text('Unknown Tab')),
                    },
                  ),
                ],
              ),
            ),
          ),
      error:
          (error, stack) => Scaffold(
            appBar: AppBar(title: const Text('Error'), centerTitle: true),
            body: Center(child: Text('Error: $error')),
          ),
      loading: () => Center(child: const CircularProgressIndicator()),
    );
  }
}
