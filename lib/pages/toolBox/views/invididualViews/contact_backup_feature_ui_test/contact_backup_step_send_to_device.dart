import 'package:flutter/material.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature/views/contact_main_page.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/blue_tooth/scan_screen.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_backup_step_bluetooth_scan.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_backup_step_choose_format.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_step_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactBackupStepSendDevice extends StatefulWidget {
  const ContactBackupStepSendDevice({super.key});

  @override
  State<ContactBackupStepSendDevice> createState() => _ContactBackupStepState();
}

class _ContactBackupStepState extends State<ContactBackupStepSendDevice> {
  String choosen = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: LinearProgressIndicator(
          color: const Color(0xff24A148),
          backgroundColor: const Color(0xffD0D0D0),
          minHeight: 7,
          value: 1.0,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '发送至',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
                color: Colors.black,
              ),
            ),
            14.verticalSpace,
            Text(
              '蓝牙设备,服务端',
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xffA8A8A8),
              ),
            ),
            29.verticalSpace,
            StepCard(
              key: const Key('option_1'),
              isChosen: choosen == '1',
              value: '1',
              title: '蓝牙',
              subTitle: '通过蓝牙传输联系人',
              icon: Icons.send_to_mobile,
              onChoosen: (String value) {
                setState(() {
                  choosen = '1';
                });
              },
            ),
            16.verticalSpace,
            StepCard(
              key: const Key('option_2'),
              isChosen: choosen == '2',
              value: '2',
              title: '服务端',
              subTitle: '上传至服务器保存',
              icon: Icons.install_mobile,
              onChoosen: (String value) {
                setState(() {
                  choosen = '2';
                });
              },
            ),
            16.verticalSpace,
            StepCard(
              key: const Key('option_3'),
              isChosen: choosen == '3',
              value: '3',
              title: '仅保存',
              subTitle: '查看本地文件',
              icon: Icons.install_mobile,
              onChoosen: (String value) {
                setState(() {
                  choosen = '3';
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () => {
          switch (choosen) {
            // Bluetooth
            '1' => Get.to(() => const ScanScreen()),
            // file upload
            // '2' => Get.to(() => ContactImExportView()),
            String() => null,
          }
        },
        child: Container(
          height: 90.h,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 24.w),
          alignment: Alignment.center,
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64.r),
              color: Colors.black,
            ),
            alignment: Alignment.center,
            child: Text(
              '确认',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
