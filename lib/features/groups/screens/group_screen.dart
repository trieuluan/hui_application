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
    final theme = Theme.of(context);

    return groupAsync.when(
      data:
          (groupData) => Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: _buildModernAppBar(context, groupData!, theme),
            body: SafeArea(
              child: Column(
                children: [
                  _buildTabSelector(context, selectedTab, theme),
                  Expanded(
                    child: _buildTabContent(selectedTab, groupData, theme),
                  ),
                ],
              ),
            ),
            floatingActionButton: _buildFloatingActionButton(
              context,
              selectedTab,
              theme,
            ),
          ),
      error:
          (error, stack) => Scaffold(
            appBar: AppBar(
              title: const Text('Lỗi'),
              centerTitle: true,
              backgroundColor: theme.colorScheme.surface,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Có lỗi xảy ra',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      loading:
          () => Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: AppBar(
              title: const Text('Hui Fund'),
              centerTitle: true,
              backgroundColor: theme.colorScheme.surface,
            ),
            body: const Center(child: CircularProgressIndicator()),
          ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(
    BuildContext context,
    Group groupData,
    ThemeData theme,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () => context.pop(),
      ),
      title: Column(
        children: [
          Text(
            groupData.name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            '${groupData.maxMembers ?? 0} thành viên tối đa',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search_rounded, color: theme.colorScheme.onSurface),
          onPressed: () {
            // TODO: Implement search functionality
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert_rounded,
            color: theme.colorScheme.onSurface,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                context.push('/groups/${widget.id}/edit');
                break;
              case 'share':
                // TODO: Implement share functionality
                break;
              case 'settings':
                context.push('/groups/${widget.id}/settings');
                break;
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      const Text('Chỉnh sửa'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      const Text('Chia sẻ'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      const Text('Cài đặt'),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  Widget _buildTabSelector(
    BuildContext context,
    String selectedTab,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(20),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            _buildTabButton(
              context,
              'overview',
              selectedTab,
              'Tổng quan',
              Icons.dashboard_rounded,
              theme,
            ),
            _buildTabButton(
              context,
              'members',
              selectedTab,
              'Thành viên',
              Icons.people_rounded,
              theme,
            ),
            _buildTabButton(
              context,
              'auction',
              selectedTab,
              'Đấu giá',
              Icons.gavel_rounded,
              theme,
            ),
            _buildTabButton(
              context,
              'history',
              selectedTab,
              'Lịch sử',
              Icons.history_rounded,
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    String tabValue,
    String selectedTab,
    String label,
    IconData icon,
    ThemeData theme,
  ) {
    final isSelected = selectedTab == tabValue;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.go('/groups/${widget.id}?tab=$tabValue');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? theme.colorScheme.primaryContainer
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color:
                    isSelected
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color:
                      isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(
    String selectedTab,
    Group groupData,
    ThemeData theme,
  ) {
    if (groupData == null) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    switch (selectedTab) {
      case 'overview':
        return GroupScreenOverview(group: groupData);
      case 'members':
        return _buildMembersTab(groupData, theme);
      case 'auction':
        return _buildAuctionTab(groupData, theme);
      case 'history':
        return _buildHistoryTab(groupData, theme);
      default:
        return const Center(child: Text('Tab không tồn tại'));
    }
  }

  Widget _buildMembersTab(Group groupData, ThemeData theme) {
    // Giả lập danh sách thành viên cho demo
    final mockMembers = [
      {'name': 'Nguyễn Văn A', 'phone': '0123456789'},
      {'name': 'Trần Thị B', 'phone': '0987654321'},
      {'name': 'Lê Văn C', 'phone': '0555666777'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thành viên (${mockMembers.length}/${groupData.maxMembers ?? 0})',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Add member functionality
                },
                icon: const Icon(Icons.person_add_rounded),
                label: const Text('Thêm'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child:
                mockMembers.isNotEmpty
                    ? ListView.builder(
                      itemCount: mockMembers.length,
                      itemBuilder: (context, index) {
                        final member = mockMembers[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Text(
                                member['name']!.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            title: Text(
                              member['name']!,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              member['phone']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                    )
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Chưa có thành viên',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Thêm thành viên đầu tiên vào nhóm',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuctionTab(Group groupData, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đấu giá',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Create auction functionality
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Tạo đấu giá'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gavel_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có đấu giá',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tạo đấu giá đầu tiên để bắt đầu',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab(Group groupData, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lịch sử hoạt động',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có hoạt động',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lịch sử hoạt động sẽ hiển thị ở đây',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton(
    BuildContext context,
    String selectedTab,
    ThemeData theme,
  ) {
    switch (selectedTab) {
      case 'members':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Add member functionality
          },
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          child: const Icon(Icons.person_add_rounded),
        );
      case 'auction':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Create auction functionality
          },
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          child: const Icon(Icons.add_rounded),
        );
      default:
        return null;
    }
  }
}
