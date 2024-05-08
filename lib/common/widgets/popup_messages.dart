import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo([String msg = ""]) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP, // 可以根据需要调整位置
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.blue[300], // 使用较浅的蓝色背景
    textColor: Colors.white, // 设置文字颜色为白色
    fontSize: 14.0, // 调整字体大小
  );
}
