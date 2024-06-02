// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeScreenBannerDotsHash() =>
    r'ef435b43868b1966413310ab4e95e893f9be65e3';

/// See also [HomeScreenBannerDots].
@ProviderFor(HomeScreenBannerDots)
final homeScreenBannerDotsProvider =
    NotifierProvider<HomeScreenBannerDots, int>.internal(
  HomeScreenBannerDots.new,
  name: r'homeScreenBannerDotsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeScreenBannerDotsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeScreenBannerDots = Notifier<int>;
String _$homeUserProfileHash() => r'269c94735a9c7c7a4fbd45c32e752b86da25547b';

/// See also [HomeUserProfile].
@ProviderFor(HomeUserProfile)
final homeUserProfileProvider =
    AutoDisposeAsyncNotifierProvider<HomeUserProfile, UserProfile>.internal(
  HomeUserProfile.new,
  name: r'homeUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeUserProfile = AutoDisposeAsyncNotifier<UserProfile>;
String _$homeVideoListHash() => r'fdd4b073dad037302e9ee9c37e02c7c04a2828fa';

/// See also [HomeVideoList].
@ProviderFor(HomeVideoList)
final homeVideoListProvider =
    AutoDisposeAsyncNotifierProvider<HomeVideoList, List<VideoItem>?>.internal(
  HomeVideoList.new,
  name: r'homeVideoListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeVideoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeVideoList = AutoDisposeAsyncNotifier<List<VideoItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
