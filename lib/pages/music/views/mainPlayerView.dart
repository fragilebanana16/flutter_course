import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/audio_helpers/page_manager.dart';
import 'package:flutter_course/pages/music/audio_helpers/service_locator.dart';
import 'package:flutter_course/pages/music/views/Widgets/playerBottomButton.dart';
import 'package:flutter_course/pages/music/views/driverModeView.dart';
import 'package:flutter_course/pages/music/views/playPlaylistView.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MainPlayerView extends StatefulWidget {
  const MainPlayerView({super.key});

  @override
  State<MainPlayerView> createState() => _MainPlayerViewState();
}

class _MainPlayerViewState extends State<MainPlayerView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    final pageManager = getIt<PageManager>();

    return Dismissible(
      key: const Key("playScreen"),
      direction: DismissDirection.down,
      background: const ColoredBox(color: Colors.transparent),
      onDismissed: (direction) {
        Get.back();
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ChillifyColor.primaryBackground,
            elevation: 0,
            actions: [
              PopupMenuButton<int>(
                  color: ChillifyColor.primaryBackground,
                  offset: const Offset(-10, 15),
                  elevation: 1,
                  icon: Image.asset(
                    "assets/images/more_btn.png",
                    width: 20,
                    height: 20,
                    color: ChillifyColor.primary,
                  ),
                  padding: EdgeInsets.zero,
                  onSelected: (selectIndex) {
                    if (selectIndex == 9) {
                      Get.to(() => const DriverModeView());
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 1,
                        height: 30,
                        child: Text(
                          "Social Share",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        height: 30,
                        child: Text(
                          "Playing Queue",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        height: 30,
                        child: Text(
                          "Add to playlist...",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 4,
                        height: 30,
                        child: Text(
                          "Lyrics",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 5,
                        height: 30,
                        child: Text(
                          "Volume",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 6,
                        height: 30,
                        child: Text(
                          "Details",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 7,
                        height: 30,
                        child: Text(
                          "Sleep timer",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 8,
                        height: 30,
                        child: Text(
                          "Equaliser",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 9,
                        height: 30,
                        child: Text(
                          "Driver mode",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ];
                  }),
            ],
          ),
          body: ValueListenableBuilder<MediaItem?>(
              valueListenable: pageManager.currentSongNotifier,
              builder: (context, mediaItem, child) {
                if (mediaItem == null) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    color: ChillifyColor.primaryBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Hero(
                                tag: "currentArtWork",
                                child: ValueListenableBuilder<MediaItem?>(
                                  valueListenable:
                                      pageManager.currentSongNotifier,
                                  builder: (context, value, child) {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            media.width * 0.7),
                                        child: CachedNetworkImage(
                                          imageUrl: mediaItem.artUri.toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              "assets/images/ar_2.png",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return Image.asset(
                                              "assets/images/ar_2.png",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          width: media.width * 0.6,
                                          height: media.width * 0.6,
                                        ));
                                  },
                                )),
                            ValueListenableBuilder(
                                valueListenable: pageManager.progressNotifier,
                                builder: (context, valueStat, child) {
                                  double? dragValue;
                                  bool dragging = false;
                                  final value = min(
                                      valueStat.current.inMilliseconds
                                          .toDouble(),
                                      valueStat.total.inMilliseconds
                                          .toDouble());

                                  return SizedBox(
                                    width: media.width * 0.6,
                                    height: media.width * 0.6,
                                    child: SleekCircularSlider(
                                      appearance: CircularSliderAppearance(
                                          customWidths: CustomSliderWidths(
                                              trackWidth: 4,
                                              progressBarWidth: 6,
                                              shadowWidth: 8),
                                          customColors: CustomSliderColors(
                                              dotColor: ChillifyColor.second,
                                              trackColor:
                                                  const Color(0xffffffff)
                                                      .withOpacity(0.3),
                                              progressBarColors: [
                                                ChillifyColor.second,
                                                ChillifyColor.third
                                              ],
                                              shadowColor:
                                                  ChillifyColor.special,
                                              shadowMaxOpacity: 0.05),
                                          infoProperties: InfoProperties(
                                            topLabelStyle: const TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            topLabelText: 'Elapsed',
                                            bottomLabelStyle: const TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            bottomLabelText: 'time',
                                            mainLabelStyle: const TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 50.0,
                                                fontWeight: FontWeight.w600),
                                            // modifier: (double value) {
                                            //   final time = printDuration(Duration(seconds: value.toInt()));
                                            //   return '$time';
                                            // }
                                          ),
                                          startAngle: 270,
                                          angleRange: 360,
                                          size: 350.0),
                                      min: 0,
                                      max: max(
                                          valueStat.current.inMilliseconds
                                              .toDouble(),
                                          valueStat.total.inMilliseconds
                                              .toDouble()),
                                      initialValue: value,
                                      onChange: (double value) {
                                        if (!dragging) {
                                          dragging = true;
                                        }

                                        setState(() {
                                          dragValue = value;
                                        });

                                        pageManager.seek(Duration(
                                            milliseconds: value.round()));
                                      },
                                      onChangeStart: (double startValue) {
                                        // callback providing a starting value (when a pan gesture starts)
                                      },
                                      onChangeEnd: (double endValue) {
                                        pageManager.seek(Duration(
                                            milliseconds: endValue.round()));
                                      },
                                    ),
                                  );
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ValueListenableBuilder(
                            valueListenable: pageManager.progressNotifier,
                            builder: (context, valueStat, child) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                            .firstMatch('${valueStat.current}')
                                            ?.group(1) ??
                                        '${valueStat.current}',
                                    style: const TextStyle(
                                        color: Color(0xFFADB9CD), fontSize: 12),
                                  ),
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        color: Color(0xFFADB9CD), fontSize: 12),
                                  ),
                                  Text(
                                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                            .firstMatch('${valueStat.total}')
                                            ?.group(1) ??
                                        '${valueStat.total}',
                                    style: const TextStyle(
                                        color: Color(0xFFADB9CD), fontSize: 12),
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          mediaItem.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFF4D6B9C),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${mediaItem.artist} - ${mediaItem.album} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFFADB9CD), fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: media.width * 0.6,
                          height: 75,
                          // color: Colors.blue,
                          child: Stack(
                            children: [
                              // previous song
                              ValueListenableBuilder(
                                  valueListenable:
                                      pageManager.isFirstSongNotifier,
                                  builder: (context, isFirst, child) {
                                    return Positioned(
                                      left: 1,
                                      top: 5,
                                      child: Container(
                                        width: 100,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color(0xFFDCE4F4),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              blurRadius: 20,
                                              offset: Offset(2, 1.5),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: (isFirst)
                                              ? null
                                              : pageManager.previous,
                                          icon: Icon(
                                            Icons.skip_previous,
                                            color: (isFirst)
                                                ? TColor.primaryText35
                                                : const Color(0xFF7B92CA),
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),

                              // next song
                              ValueListenableBuilder(
                                  valueListenable:
                                      pageManager.isLastSongNotifier,
                                  builder: (context, isLast, child) {
                                    return Positioned(
                                      right: 1,
                                      top: 5,
                                      child: Container(
                                          width: 100,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color(0xFFDCE4F4),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.15),
                                                blurRadius: 20,
                                                offset: const Offset(2, 1.5),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            onPressed: (isLast)
                                                ? null
                                                : pageManager.next,
                                            icon: Icon(
                                              Icons.skip_next,
                                              color: (isLast)
                                                  ? TColor.primaryText35
                                                  : const Color(0xFF7B92CA),
                                              size: 40,
                                            ),
                                          )),
                                    );
                                  }),
                              // play/pause
                              ValueListenableBuilder(
                                  valueListenable:
                                      pageManager.playButtonNotifier,
                                  builder: (context, value, child) {
                                    return Positioned(
                                      left: (media.width * 0.6) / 2 - 75 / 2,
                                      child: SizedBox(
                                        width: 75,
                                        height: 75,
                                        child: Stack(
                                          children: [
                                            if (value == ButtonState.loading)
                                              SizedBox(
                                                width: 75,
                                                height: 75,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          TColor.primaryText),
                                                ),
                                              ),
                                            Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.15),
                                                      blurRadius: 30,
                                                      offset:
                                                          const Offset(2, 1.5),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: AnimatedCrossFade(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    crossFadeState: value ==
                                                            ButtonState.playing
                                                        ? CrossFadeState
                                                            .showFirst
                                                        : CrossFadeState
                                                            .showSecond,
                                                    firstChild: InkWell(
                                                        onTap:
                                                            pageManager.pause,
                                                        child: const Icon(
                                                          Icons.pause,
                                                          size: 50,
                                                          color:
                                                              Color(0xFF7B92CA),
                                                        )),
                                                    secondChild: InkWell(
                                                        onTap: pageManager.play,
                                                        child: const Icon(
                                                          Icons.play_arrow,
                                                          size: 50,
                                                          color:
                                                              Color(0xFF7B92CA),
                                                        )),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayerBottomButton(
                                title: "Playlist",
                                icon: "assets/images/playlist.png",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder: (_, __, ___) =>
                                            const PlayPlayListView(),
                                      ));
                                }),
                            PlayerBottomButton(
                                title: "Shuffle",
                                icon: "assets/images/shuffle.png",
                                onPressed: () {}),
                            PlayerBottomButton(
                                title: "Repeat",
                                icon: "assets/images/repeat.png",
                                onPressed: () {}),
                            PlayerBottomButton(
                                title: "EQ",
                                icon: "assets/images/eq.png",
                                onPressed: () {}),
                            PlayerBottomButton(
                                title: "Favourites",
                                icon: "assets/images/fav.png",
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
