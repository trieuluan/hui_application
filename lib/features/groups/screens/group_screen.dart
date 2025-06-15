import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final String id;
  const GroupScreen({super.key, required this.id});

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedTab =
        Uri.parse(location).queryParameters['tab'] ?? 'overview';

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(CupertinoIcons.back, size: 24),
        ),
        middle: const Text(
          'Hui Fund',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Handle search action
              },
              child: const Icon(CupertinoIcons.search, size: 24),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                // Handle add group action
              },
              child: const Icon(CupertinoIcons.slider_horizontal_3, size: 24),
            ),
          ],
        ),
      ),
      child: Scaffold(
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
              const SizedBox(height: 24),
              Expanded(
                child: switch (selectedTab) {
                  'overview' => const Center(child: Text('Overview')),
                  'members' => const Center(child: Text('Members')),
                  'invoice' => const Center(child: Text('Invoices')),
                  _ => const Center(child: Text('Unknown Tab')),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
