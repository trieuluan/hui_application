import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/network/api_client.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_service.g.dart';

@riverpod
GroupService groupService(Ref ref) {
  final api = ref.read(apiclientProvider);
  return GroupService(api);
}

class GroupService {
  final ApiClient _api;

  GroupService(this._api);

  Future<List<Group>> getGroups() async {
    // Simulate a network call
    try {
      final result = await _api.get('/groups');
      return (result.data as List).map((e) => Group.fromJson(e)).toList();
    } on ApiException {
      rethrow;
    }
  }

  Future<Group> getGroup(String groupId) async {
    // Simulate a network call
    try {
      final result = await _api.get('/groups/$groupId');
      return Group.fromJson(result.data);
    } on ApiException {
      rethrow;
    }
  }

  Future<Group> createGroup(Group group) async {
    // Simulate a network call
    try {
      final result = await _api.post(
        '/groups',
        data: group.toJsonWithoutNull(),
      );
      return Group.fromJson(result.data);
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteGroup(String groupId) async {
    // Simulate a network call
    try {
      final result = await _api.delete('/groups/$groupId');
      return result.data;
    } on ApiException {
      rethrow;
    }
  }
}
