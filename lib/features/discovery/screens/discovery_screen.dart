import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/features/discovery/providers/discovery_provider.dart';
import 'package:hui_application/features/discovery/widgets/hui_group_card.dart';
import 'package:hui_application/features/discovery/widgets/search_filter_bar.dart';

class DiscoveryScreen extends ConsumerStatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  ConsumerState<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends ConsumerState<DiscoveryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(discoveryNotifierProvider.notifier).loadGroups();
    });
  }

  @override
  Widget build(BuildContext context) {
    final discoveryState = ref.watch(discoveryNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(theme),

            // Search and Filter
            SearchFilterBar(
              onSearchChanged: (query) {
                ref
                    .read(discoveryNotifierProvider.notifier)
                    .updateSearchQuery(query);
              },
              onLocationChanged: (location) {
                ref
                    .read(discoveryNotifierProvider.notifier)
                    .updateLocation(location);
              },
              onAmountChanged: (amount) {
                ref
                    .read(discoveryNotifierProvider.notifier)
                    .updateAmount(amount);
              },
              onDurationChanged: (duration) {
                ref
                    .read(discoveryNotifierProvider.notifier)
                    .updateDuration(duration);
              },
            ),

            // Content
            Expanded(child: _buildContent(discoveryState, theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.explore, color: theme.colorScheme.primary, size: 28),
          const SizedBox(width: 12),
          Text(
            'Khám phá hụi',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              ref.read(discoveryNotifierProvider.notifier).loadGroups();
            },
            icon: Icon(
              Icons.refresh,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(discoveryState, ThemeData theme) {
    if (discoveryState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (discoveryState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Có lỗi xảy ra', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              discoveryState.error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(discoveryNotifierProvider.notifier).loadGroups();
              },
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    final filteredGroups =
        ref.read(discoveryNotifierProvider.notifier).filteredGroups;

    if (filteredGroups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text('Không tìm thấy hụi nào', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Thử thay đổi bộ lọc hoặc tìm kiếm',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(discoveryNotifierProvider.notifier).loadGroups();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredGroups.length,
        itemBuilder: (context, index) {
          final group = filteredGroups[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HuiGroupCard(
              group: group,
              onJoinRequest: () async {
                await ref
                    .read(discoveryNotifierProvider.notifier)
                    .requestJoin(group.id);
                if (mounted) {
                  showGlobalSuccessSnackBar(
                    message: 'Đã gửi yêu cầu tham gia hụi "${group.name}"',
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
