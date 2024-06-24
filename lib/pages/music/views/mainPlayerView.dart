import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: TColor.bg,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                "assets/images/back.png",
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              "Now Playing",
              style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              PopupMenuButton<int>(
                  color: const Color(0xff383B49),
                  offset: const Offset(-10, 15),
                  elevation: 1,
                  icon: Image.asset(
                    "assets/images/more_btn.png",
                    width: 20,
                    height: 20,
                    color: Colors.white,
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
                    color: TColor.bg,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
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
                                            imageUrl:
                                                mediaItem.artUri.toString(),
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
                                                dotColor:
                                                    const Color(0xffFFB1B2),
                                                trackColor:
                                                    const Color(0xffffffff)
                                                        .withOpacity(0.3),
                                                progressBarColors: [
                                                  const Color(0xffFB9967),
                                                  const Color(0xffE9585A)
                                                ],
                                                shadowColor:
                                                    const Color(0xffFFB1B2),
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
                            height: 10,
                          ),
                          ValueListenableBuilder(
                              valueListenable: pageManager.progressNotifier,
                              builder: (context, valueStat, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                              .firstMatch(
                                                  '${valueStat.current}')
                                              ?.group(1) ??
                                          '${valueStat.current}',
                                      style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                              .firstMatch('${valueStat.total}')
                                              ?.group(1) ??
                                          '${valueStat.total}',
                                      style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 12),
                                    ),
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            mediaItem.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: TColor.primaryText.withOpacity(0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${mediaItem.artist} - ${mediaItem.album} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "assets/images/eq_display.png",
                            height: 60,
                            fit: BoxFit.fitHeight,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Divider(
                              color: Colors.white12,
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable:
                                      pageManager.isFirstSongNotifier,
                                  builder: (context, isFirst, child) {
                                    return SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: IconButton(
                                          onPressed: (isFirst)
                                              ? null
                                              : pageManager.previous,
                                          icon: Image.asset(
                                            "assets/images/previous_song.png",
                                            color: (isFirst)
                                                ? TColor.primaryText35
                                                : TColor.primaryText,
                                          ),
                                        ));
                                  }),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/images/play.png",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ValueListenableBuilder(
                                  valueListenable:
                                      pageManager.isLastSongNotifier,
                                  builder: (context, isLast, child) {
                                    return SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: IconButton(
                                          onPressed: (isLast)
                                              ? null
                                              : pageManager.next,
                                          icon: Image.asset(
                                            "assets/images/next_song.png",
                                            color: (isLast)
                                                ? TColor.primaryText35
                                                : TColor.primaryText,
                                          ),
                                        ));
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PlayerBottomButton(
                                  title: "Playlist",
                                  icon: "assets/images/playlist.png",
                                  onPressed: () {
                                    Get.to(() => const PlayPlayListView());
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
                  ),
                );
              })),
    );
  }
}
