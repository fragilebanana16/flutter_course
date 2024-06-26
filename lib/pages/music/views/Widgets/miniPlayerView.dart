import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'dart:ui' as ui;
import 'package:flutter_course/pages/music/audio_helpers/page_manager.dart';
import 'package:flutter_course/pages/music/audio_helpers/service_locator.dart';
import 'package:flutter_course/pages/music/views/Widgets/controlButtons.dart';
import 'package:flutter_course/pages/music/views/mainPlayerView.dart';

class MiniPlayerView extends StatefulWidget {
  static const MiniPlayerView _instance = MiniPlayerView._internal();

  factory MiniPlayerView() {
    return _instance;
  }

  const MiniPlayerView._internal();

  @override
  State<MiniPlayerView> createState() => _MiniPlaerViewState();
}

class _MiniPlaerViewState extends State<MiniPlayerView> {
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return ValueListenableBuilder(
        valueListenable: pageManager.playbackStatNotifier,
        builder: (context, processingState, _) {
          if (processingState == AudioProcessingState.idle) {
            return const SizedBox();
          }

          return ValueListenableBuilder<MediaItem?>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (context, mediaItem, _) {
              print(mediaItem);
              if (mediaItem == null) {
                return const SizedBox();
              }

              return Dismissible(
                  key: const Key('min_player'),
                  direction: DismissDirection.down,
                  onDismissed: (direction) {
                    Feedback.forLongPress(context);
                    pageManager.stop();
                  },
                  child: Dismissible(
                    key: Key(mediaItem.id),
                    confirmDismiss: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        pageManager.previous();
                      } else {
                        pageManager.next();
                      }

                      return Future.value(false);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 1.0),
                      elevation: 0,
                      color: TColor.bg,
                      child: SizedBox(
                        height: 70.0,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: 40,
                              sigmaY: 40,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ValueListenableBuilder<ProgressBarState>(
                                    valueListenable:
                                        pageManager.progressNotifier,
                                    builder: (context, value, _) {
                                      final position = value.current;
                                      final totalDuration = value.total;
                                      return position == null
                                          ? const SizedBox()
                                          : (position.inSeconds.toDouble() <
                                                      0.0 ||
                                                  (position.inSeconds
                                                          .toDouble() >
                                                      totalDuration
                                                          .inSeconds
                                                          .toDouble()))
                                              ? const SizedBox()
                                              : SliderTheme(
                                                  data: SliderThemeData(
                                                      activeTrackColor:
                                                          TColor.focus,
                                                      inactiveTrackColor:
                                                          Colors.transparent,
                                                      trackHeight: 3,
                                                      thumbColor: TColor.focus,
                                                      thumbShape:
                                                          const RoundSliderOverlayShape(
                                                              overlayRadius:
                                                                  1.5),
                                                      overlayColor:
                                                          Colors.transparent,
                                                      overlayShape:
                                                          const RoundSliderOverlayShape(
                                                              overlayRadius:
                                                                  1.0)),
                                                  child: Center(
                                                    child: Slider(
                                                        inactiveColor:
                                                            Colors.transparent,
                                                        value: position
                                                            .inSeconds
                                                            .toDouble(),
                                                        max: totalDuration
                                                            .inSeconds
                                                            .toDouble(),
                                                        onChanged:
                                                            (newPosition) {
                                                          pageManager.seek(
                                                            Duration(
                                                                seconds:
                                                                    newPosition
                                                                        .round()),
                                                          );
                                                        }),
                                                  ));
                                    }),
                                Container(
                                  child: ListTile(
                                    dense: true,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder: (_, __, ___) =>
                                                const MainPlayerView(),
                                          ));
                                    },
                                    title: Text(
                                      mediaItem.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      mediaItem.artist ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    leading: Hero(
                                        tag: 'currentArtWokr',
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: SizedBox.square(
                                            dimension: 40.0,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    child: CachedNetworkImage(
                                                      imageUrl: mediaItem.artUri
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Image.asset(
                                                          "assets/images/ar_2.png",
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                      placeholder:
                                                          (context, url) {
                                                        return Image.asset(
                                                          "assets/images/ar_2.png",
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                      width: 40,
                                                      height: 40,
                                                    )),
                                                //  album outline
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: TColor
                                                            .primaryText28),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    trailing: const ControlButtons(
                                      miniPlayer: true,
                                      buttons: ['Play/Pause', 'Next'],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
