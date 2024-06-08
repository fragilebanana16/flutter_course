import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/button_widget.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDetailThumbnail extends StatelessWidget {
  final VideoItem videoItem;
  const VideoDetailThumbnail({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return AppBoxDecoration(
      width: 325.w,
      height: 240.h,
      hasMask: false,
      imagePath: "${AppConstants.SERVER_API_URL}${videoItem.thumbNail}",
    );
  }
}

class VideoDetailBrief extends StatelessWidget {
  final VideoItem videoItem;
  const VideoDetailBrief({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: 325.w,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: appBoxShadow(radius: 7),
              child: const Text10Normal(
                text: "Author Page",
                color: AppColors.primaryElementText,
              ),
            ),
          ),
          Expanded(child: Container()),
          // 时长
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              children: [
                AppIcon(
                  icon: Icons.access_time,
                ),
                Text11Normal(
                  text: videoItem.videoLen!,
                  color: AppColors.primaryThirdElementText,
                )
              ],
            ),
          ),
          // 收藏
          Container(
            margin: EdgeInsets.only(left: 10.w),
            child: Row(
              children: [
                AppIcon(
                  icon: Icons.star,
                ),
                Text11Normal(
                  text: "已收藏",
                  color: AppColors.primaryThirdElementText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoMoreDetail extends StatelessWidget {
  final VideoItem videoItem;
  const VideoMoreDetail({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        width: 325.w,
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text16Normal(
              text: videoItem.name == null ? "No Name Found" : videoItem.name!,
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text11Normal(
                  text: videoItem.description == null
                      ? "No Description Found"
                      : videoItem.description!,
                  color: AppColors.primaryThirdElementText),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              decoration: const BoxDecoration(
                  color: Color(0x44000000),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              padding: const EdgeInsets.all(12.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                    child: Text(
                      '剧情简介',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "这是一场你死我活的较量 —— 无论是在这片土地驻扎已久的原始部落宗理的加持人们戏完全支持你在本地独自享受、或在最多容纳50人的官方服务器上参与多人模式，也允许你建立自己掌控的局域网主机或私人服务器并邀请他人加入。只要在非官方服务器的环境下，你都可以通过自定义大量的游戏参数来调节属于你偏好的游戏体验，更多丰富的细节设置等着你慢慢探索。",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const AppButton(buttonName: '观看')
          ]),
        ));
  }
}

class VideoSeries extends StatelessWidget {
  final List<VideoItem> videoList;
  const VideoSeries({super.key, required this.videoList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        videoList.isNotEmpty
            ? const Text14Normal(
                text: "选集",
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              )
            : SizedBox(),
        SizedBox(
          height: 10.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: videoList.length,
            itemBuilder: (_, index) {
              return Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 325.w,
                  height: 80.h,
                  decoration: appBoxShadow(
                      radius: 10,
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("/videoDetail",
                          arguments: {"id": videoList[index].id!});
                    },
                    child: Row(
                      children: [
                        AppBoxDecoration(
                            width: 60.w,
                            height: 60.h,
                            hasMask: false,
                            imagePath:
                                "${AppConstants.SERVER_API_URL}${videoList[index].thumbNail}"),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text11Normal(
                                text: videoList[index].name!,
                                color: AppColors.primaryText),
                            Text10Normal(
                                text: videoList[index].description!,
                                color: AppColors.primaryThirdElementText),
                          ],
                        ),
                        Expanded(child: Container()),
                        AppIcon(
                          icon: Icons.arrow_forward_ios,
                          size: 24,
                          color: AppColors.primaryText,
                        )
                      ],
                    ),
                  ));
            }),
      ]),
    );
  }
}
