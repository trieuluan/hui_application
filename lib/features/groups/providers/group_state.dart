import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hui_application/features/groups/models/group.dart';

part 'group_state.freezed.dart';

enum GroupStateType { initial, loading, loaded, error }

@freezed
class GroupState with _$GroupState {
  const factory GroupState.initial() = _Initial;
  const factory GroupState.loading() = _Loading;
  const factory GroupState.loaded({required List<Group> groups}) = _Loaded;
  const factory GroupState.error(String message) = _Error;
}

extension GroupStateX on GroupState {
  List<Group>? get groups {
    if (this is _Loaded) {
      return (this as _Loaded).groups;
    }
    return null;
  }

  String? get errorMessage {
    if (this is _Error) {
      return (this as _Error).message;
    }
    return null;
  }

  GroupStateType get type {
    if (this is _Initial) {
      return GroupStateType.initial;
    } else if (this is _Loading) {
      return GroupStateType.loading;
    } else if (this is _Loaded) {
      return GroupStateType.loaded;
    } else if (this is _Error) {
      return GroupStateType.error;
    }
    throw Exception('Unknown state type');
  }
}
