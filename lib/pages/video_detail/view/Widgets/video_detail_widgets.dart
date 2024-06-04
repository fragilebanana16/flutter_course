import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDetailThumbnail extends StatelessWidget {
  final VideoItem videoItem;
  const VideoDetailThumbnail({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0.h),
      child: AppBoxDecoration(
        width: 325.w,
        height: 240.h,
        imagePath: "${AppConstants.SERVER_API_URL}${videoItem.thumbNail}",
      ),
    );
  }
}
