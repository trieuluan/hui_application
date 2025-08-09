import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/discovery/models/discovery_state.dart';

class DiscoveryNotifier extends StateNotifier<DiscoveryState> {
  DiscoveryNotifier() : super(const DiscoveryState());

  Future<void> loadGroups() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      final mockGroups = [
        HuiGroupPreview(
          id: '1',
          name: 'Hụi gia đình',
          ownerName: 'Nguyễn Văn A',
          amount: 1000000,
          duration: 12,
          location: 'Hà Nội',
          memberCount: 8,
          maxMembers: 12,
          privacy: GroupPrivacy.public,
          joinStatus: JoinStatus.available,
          createdAt: DateTime.now(),
        ),
        HuiGroupPreview(
          id: '2',
          name: 'Hụi đồng nghiệp',
          ownerName: 'Trần Thị B',
          amount: 2000000,
          duration: 6,
          location: 'TP.HCM',
          memberCount: 10,
          maxMembers: 10,
          privacy: GroupPrivacy.inviteOnly,
          joinStatus: JoinStatus.full,
          createdAt: DateTime.now(),
        ),
        HuiGroupPreview(
          id: '3',
          name: 'Hụi bạn bè',
          ownerName: 'Lê Văn C',
          amount: 500000,
          duration: 8,
          location: 'Đà Nẵng',
          memberCount: 5,
          maxMembers: 8,
          privacy: GroupPrivacy.public,
          joinStatus: JoinStatus.requested,
          createdAt: DateTime.now(),
        ),
      ];

      state = state.copyWith(groups: mockGroups, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateLocation(String location) {
    state = state.copyWith(selectedLocation: location);
  }

  void updateAmount(double amount) {
    state = state.copyWith(selectedAmount: amount);
  }

  void updateDuration(int duration) {
    state = state.copyWith(selectedDuration: duration);
  }

  Future<void> requestJoin(String groupId) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      final updatedGroups =
          state.groups.map((group) {
            if (group.id == groupId) {
              return group.copyWith(joinStatus: JoinStatus.requested);
            }
            return group;
          }).toList();

      state = state.copyWith(groups: updatedGroups);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  List<HuiGroupPreview> get filteredGroups {
    var filtered = state.groups;

    // Filter by search query
    if (state.searchQuery.isNotEmpty) {
      filtered =
          filtered
              .where(
                (group) =>
                    group.name.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ) ||
                    group.ownerName.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ) ||
                    group.location.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Filter by location
    if (state.selectedLocation.isNotEmpty) {
      filtered =
          filtered
              .where((group) => group.location == state.selectedLocation)
              .toList();
    }

    // Filter by amount
    if (state.selectedAmount > 0) {
      filtered =
          filtered
              .where((group) => group.amount <= state.selectedAmount)
              .toList();
    }

    // Filter by duration
    if (state.selectedDuration > 0) {
      filtered =
          filtered
              .where((group) => group.duration <= state.selectedDuration)
              .toList();
    }

    return filtered;
  }
}

final discoveryNotifierProvider =
    StateNotifierProvider<DiscoveryNotifier, DiscoveryState>(
      (ref) => DiscoveryNotifier(),
    );
