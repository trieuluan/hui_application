import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/features/groups/providers/group_state.dart';
import 'package:hui_application/features/groups/services/group_service.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_provider.g.dart';

@Riverpod(keepAlive: true)
class GroupNotifier extends _$GroupNotifier {
  @override
  GroupState build() => const GroupState.initial();

  Future<void> fetchGroups() async {
    state = const GroupState.loading();
    try {
      final groupService = ref.read(groupServiceProvider);
      final groups = await groupService.getGroups();
      state = GroupState.loaded(groups: groups);
    } on ApiException catch (e) {
      state = GroupState.error(e.message.toString());
      rethrow;
    }
  }

  Future<bool> createGroup(Group group) async {
    final groups = List<Group>.from(state.groups ?? []);
    state = const GroupState.loading();
    try {
      final groupService = ref.read(groupServiceProvider);
      final newGroup = await groupService.createGroup(group);
      groups.add(newGroup);
      state = GroupState.loaded(groups: groups);
      return true;
    } on ApiException catch (e) {
      state = GroupState.error(e.message.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteGroup(String groupId) async {
    final groups = List<Group>.from(state.groups ?? []);
    state = const GroupState.loading();
    try {
      final groupService = ref.read(groupServiceProvider);
      final result = await groupService.deleteGroup(groupId);
      groups.removeWhere((group) => group.id == groupId);
      state = GroupState.loaded(groups: groups);
      return result;
    } on ApiException catch (e) {
      state = GroupState.error(e.message.toString());
      rethrow;
    }
  }
}

@riverpod
Future<Group?> groupDetail(Ref ref, String groupId) async {
  final groupService = ref.read(groupServiceProvider);
  return await groupService.getGroup(groupId);
}
