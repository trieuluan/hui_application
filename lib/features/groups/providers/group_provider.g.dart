// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupDetailHash() => r'2fd43bb6bcbb565b6786e70646594a1fb2c75875';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [groupDetail].
@ProviderFor(groupDetail)
const groupDetailProvider = GroupDetailFamily();

/// See also [groupDetail].
class GroupDetailFamily extends Family<AsyncValue<Group?>> {
  /// See also [groupDetail].
  const GroupDetailFamily();

  /// See also [groupDetail].
  GroupDetailProvider call(String groupId) {
    return GroupDetailProvider(groupId);
  }

  @override
  GroupDetailProvider getProviderOverride(
    covariant GroupDetailProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupDetailProvider';
}

/// See also [groupDetail].
class GroupDetailProvider extends AutoDisposeFutureProvider<Group?> {
  /// See also [groupDetail].
  GroupDetailProvider(String groupId)
    : this._internal(
        (ref) => groupDetail(ref as GroupDetailRef, groupId),
        from: groupDetailProvider,
        name: r'groupDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$groupDetailHash,
        dependencies: GroupDetailFamily._dependencies,
        allTransitiveDependencies: GroupDetailFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<Group?> Function(GroupDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupDetailProvider._internal(
        (ref) => create(ref as GroupDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Group?> createElement() {
    return _GroupDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupDetailProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupDetailRef on AutoDisposeFutureProviderRef<Group?> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupDetailProviderElement
    extends AutoDisposeFutureProviderElement<Group?>
    with GroupDetailRef {
  _GroupDetailProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupDetailProvider).groupId;
}

String _$groupNotifierHash() => r'2e6d9ae1b7d3a599011aa366217d6de6586420e5';

/// See also [GroupNotifier].
@ProviderFor(GroupNotifier)
final groupNotifierProvider =
    NotifierProvider<GroupNotifier, GroupState>.internal(
      GroupNotifier.new,
      name: r'groupNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$groupNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GroupNotifier = Notifier<GroupState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
