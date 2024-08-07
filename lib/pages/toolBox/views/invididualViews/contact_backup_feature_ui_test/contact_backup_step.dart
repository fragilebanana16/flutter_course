import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/tip_prompt.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature/views/contact_main_page.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/blue_tooth/scan_screen.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_backup_step_choose_format.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_step_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactBackupStep extends StatefulWidget {
  const ContactBackupStep({super.key});

  @override
  State<ContactBackupStep> createState() => _ContactBackupStepState();
}

class _ContactBackupStepState extends State<ContactBackupStep> {
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
          value: 0.3,
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
              '联系人导入导出',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
                color: Colors.black,
              ),
            ),
            14.verticalSpace,
            Text(
              '导出支持csv, excel, pdf,导入支持excel',
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
              title: '导出',
              subTitle: '导出联系人',
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
              title: '导入',
              subTitle: '操作会覆盖已有联系人',
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
              value: '2',
              title: '发送',
              subTitle: '发送给其他设备',
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
        onTap: () async {
          // [todo] if file exists, prompt to override, or backup it

          switch (choosen) {
            // import
            case '1':
              Get.to(() => const ContactBackupStepChooseFormat());
            //export
            case '2':
              Get.to(() => ContactImExportView());
            //send device
            case '3':
              Get.to(() => ScanScreen());
            case String():
              null;
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
              '继续',
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
