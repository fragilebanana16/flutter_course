import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/message.dart';
import 'package:flutter_course/common/utils/constants.dart';

class ReplyImageCard extends StatelessWidget {
  const ReplyImageCard({Key? key, required this.image}) : super(key: key);
  final ImageDetail image;

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width / 2.8;
    var mediaHeight = MediaQuery.of(context).size.height / 2.3;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          height: getDisplayHeight(image, mediaWidth, mediaHeight),
          width: getDisplayWidth(image, mediaWidth, mediaHeight),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green[300]),
          child: Card(
            margin: EdgeInsets.all(3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                      "${AppConstants.SERVER_API_URL}${image.imgPath}"),
                  fit: BoxFit.fill),
            )),
          ),
        ),
      ),
    );
  }

  double getDisplayHeight(
      ImageDetail imageDetail, double mediaWidth, double mediaHeight) {
    if (imageDetail.imgWidth > mediaWidth) {
      return mediaWidth;
    } else {
      return imageDetail.imgHeight.toDouble();
    }
  }

  double getDisplayWidth(
      ImageDetail imageDetail, double mediaWidth, double mediaHeight) {
    if (imageDetail.imgWidth > mediaWidth) {
      return (imageDetail.imgWidth.toDouble() /
              imageDetail.imgHeight.toDouble()) *
          mediaWidth;
    } else {
      return imageDetail.imgWidth.toDouble();
    }
  }
}
