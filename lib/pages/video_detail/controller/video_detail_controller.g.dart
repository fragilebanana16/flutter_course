// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$videoDetailControllerHash() =>
    r'ac86bef0c78a097435607e85be3c2302c5aa578e';

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

typedef VideoDetailControllerRef = AutoDisposeFutureProviderRef<VideoItem?>;

/// See also [videoDetailController].
@ProviderFor(videoDetailController)
const videoDetailControllerProvider = VideoDetailControllerFamily();

/// See also [videoDetailController].
class VideoDetailControllerFamily extends Family<AsyncValue<VideoItem?>> {
  /// See also [videoDetailController].
  const VideoDetailControllerFamily();

  /// See also [videoDetailController].
  VideoDetailControllerProvider call({
    required int index,
  }) {
    return VideoDetailControllerProvider(
      index: index,
    );
  }

  @override
  VideoDetailControllerProvider getProviderOverride(
    covariant VideoDetailControllerProvider provider,
  ) {
    return call(
      index: provider.index,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'videoDetailControllerProvider';
}

/// See also [videoDetailController].
class VideoDetailControllerProvider
    extends AutoDisposeFutureProvider<VideoItem?> {
  /// See also [videoDetailController].
  VideoDetailControllerProvider({
    required this.index,
  }) : super.internal(
          (ref) => videoDetailController(
            ref,
            index: index,
          ),
          from: videoDetailControllerProvider,
          name: r'videoDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoDetailControllerHash,
          dependencies: VideoDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              VideoDetailControllerFamily._allTransitiveDependencies,
        );

  final int index;

  @override
  bool operator ==(Object other) {
    return other is VideoDetailControllerProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
