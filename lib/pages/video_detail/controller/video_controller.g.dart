// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$videoControllerHash() => r'6b67d385a3428e667db7924a0ad715674dc8a324';

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

typedef VideoControllerRef = AutoDisposeFutureProviderRef<VideoItem?>;

/// See also [videoController].
@ProviderFor(videoController)
const videoControllerProvider = VideoControllerFamily();

/// See also [videoController].
class VideoControllerFamily extends Family<AsyncValue<VideoItem?>> {
  /// See also [videoController].
  const VideoControllerFamily();

  /// See also [videoController].
  VideoControllerProvider call({
    required int index,
  }) {
    return VideoControllerProvider(
      index: index,
    );
  }

  @override
  VideoControllerProvider getProviderOverride(
    covariant VideoControllerProvider provider,
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
  String? get name => r'videoControllerProvider';
}

/// See also [videoController].
class VideoControllerProvider extends AutoDisposeFutureProvider<VideoItem?> {
  /// See also [videoController].
  VideoControllerProvider({
    required this.index,
  }) : super.internal(
          (ref) => videoController(
            ref,
            index: index,
          ),
          from: videoControllerProvider,
          name: r'videoControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoControllerHash,
          dependencies: VideoControllerFamily._dependencies,
          allTransitiveDependencies:
              VideoControllerFamily._allTransitiveDependencies,
        );

  final int index;

  @override
  bool operator ==(Object other) {
    return other is VideoControllerProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$videoListControllerHash() =>
    r'6575ffba0f70262a8c6283d86982f178d649d195';
typedef VideoListControllerRef = AutoDisposeFutureProviderRef<List<VideoItem>?>;

/// See also [videoListController].
@ProviderFor(videoListController)
const videoListControllerProvider = VideoListControllerFamily();

/// See also [videoListController].
class VideoListControllerFamily extends Family<AsyncValue<List<VideoItem>?>> {
  /// See also [videoListController].
  const VideoListControllerFamily();

  /// See also [videoListController].
  VideoListControllerProvider call({
    required int index,
  }) {
    return VideoListControllerProvider(
      index: index,
    );
  }

  @override
  VideoListControllerProvider getProviderOverride(
    covariant VideoListControllerProvider provider,
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
  String? get name => r'videoListControllerProvider';
}

/// See also [videoListController].
class VideoListControllerProvider
    extends AutoDisposeFutureProvider<List<VideoItem>?> {
  /// See also [videoListController].
  VideoListControllerProvider({
    required this.index,
  }) : super.internal(
          (ref) => videoListController(
            ref,
            index: index,
          ),
          from: videoListControllerProvider,
          name: r'videoListControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoListControllerHash,
          dependencies: VideoListControllerFamily._dependencies,
          allTransitiveDependencies:
              VideoListControllerFamily._allTransitiveDependencies,
        );

  final int index;

  @override
  bool operator ==(Object other) {
    return other is VideoListControllerProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$videoPlayInfoControllerHash() =>
    r'b0e17228539f31a529b195226580d37ae88dc04a';

/// See also [VideoPlayInfoController].
@ProviderFor(VideoPlayInfoController)
final videoPlayInfoControllerProvider = AutoDisposeAsyncNotifierProvider<
    VideoPlayInfoController, VideoPlayInfo>.internal(
  VideoPlayInfoController.new,
  name: r'videoPlayInfoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$videoPlayInfoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VideoPlayInfoController = AutoDisposeAsyncNotifier<VideoPlayInfo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
