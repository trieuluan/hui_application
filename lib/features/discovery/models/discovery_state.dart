import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovery_state.freezed.dart';

@freezed
abstract class DiscoveryState with _$DiscoveryState {
  const factory DiscoveryState({
    @Default([]) List<HuiGroupPreview> groups,
    @Default(false) bool isLoading,
    @Default('') String searchQuery,
    @Default('') String selectedLocation,
    @Default(0.0) double selectedAmount,
    @Default(0) int selectedDuration,
    String? error,
  }) = _DiscoveryState;
}

@freezed
abstract class HuiGroupPreview with _$HuiGroupPreview {
  const factory HuiGroupPreview({
    required String id,
    required String name,
    required String ownerName,
    required double amount,
    required int duration,
    required String location,
    required int memberCount,
    required int maxMembers,
    required GroupPrivacy privacy,
    required JoinStatus joinStatus,
    required DateTime createdAt,
  }) = _HuiGroupPreview;
}

enum GroupPrivacy { public, inviteOnly, private }

enum JoinStatus { available, requested, joined, full }
