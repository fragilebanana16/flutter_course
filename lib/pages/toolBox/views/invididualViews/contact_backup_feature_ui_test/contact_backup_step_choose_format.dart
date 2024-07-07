import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature/services/export_helper.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_backup_step_send_to_device.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/contact_step_card.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature_ui_test/util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactBackupStepChooseFormat extends StatefulWidget {
  const ContactBackupStepChooseFormat({super.key});

  @override
  State<ContactBackupStepChooseFormat> createState() =>
      _ContactBackupStepChooseFormatState();
}

class _ContactBackupStepChooseFormatState
    extends State<ContactBackupStepChooseFormat> {
  String choosen = '1';
  ExportContactFileTypes? _groupValue = ExportContactFileTypes.xlsx;
  bool isExporting = false;
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
          color: Color(0xff24A148),
          backgroundColor: Color(0xffD0D0D0),
          minHeight: 7,
          value: 0.6,
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
              '请选择导出格式',
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
              key: const Key('formatOption_1'),
              isChosen: choosen == '1',
              value: '1',
              title: 'XLSX',
              icon: Icons.fitness_center,
              onChoosen: (String value) {
                setState(() {
                  choosen = '1';
                });
              },
            ),
            16.verticalSpace,
            StepCard(
              key: const Key('formatOption_2'),
              isChosen: choosen == '2',
              value: '2',
              title: 'PDF',
              icon: Icons.line_weight,
              onChoosen: (String value) {
                setState(() {
                  choosen = '2';
                });
              },
            ),
            16.verticalSpace,
            StepCard(
              key: const Key('formatOption_3'),
              isChosen: choosen == '3',
              value: '3',
              title: 'CSV',
              icon: Icons.line_weight,
              onChoosen: (String value) {
                setState(() {
                  choosen = '3';
                });
              },
            ),
            16.verticalSpace,
            Text(
              '**注意：导入只支持excel',
              style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xffA8A8A8),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: isExporting
            ? null
            : () async {
                bool isSuccess = false;
                await Permission.contacts.request();
                String path =
                    await ExternalPath.getExternalStoragePublicDirectory(
                        ExternalPath.DIRECTORY_DOWNLOADS);
                String fileName = '';
                switch (_groupValue) {
                  case ExportContactFileTypes.xlsx:
                    fileName = '$path/Contacts.xlsx';
                  case ExportContactFileTypes.csv:
                    fileName = '$path/Contacts.csv';
                  case ExportContactFileTypes.pdf:
                    fileName = '$path/Contacts.pdf';
                    break;
                  default:
                }

                var oldFile = File(fileName);
                if (oldFile.existsSync()) {
                  var dlgRet = await alertDialog('是否覆盖', '存在同名文件，是否覆盖？');
                  if (dlgRet != true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('取消操作...'),
                      ),
                    );
                    return;
                  }
                }

                setState(() {
                  isExporting = true;
                });
                ExportHelper exportHelper = ExportHelper(
                    contactsList: await ContactsService.getContacts());
                if (_groupValue == ExportContactFileTypes.xlsx) {
                  isSuccess = await _exportXLSX(exportHelper);
                } else if (_groupValue == ExportContactFileTypes.pdf) {
                  isSuccess = await _exportPDF(exportHelper);
                } else if (_groupValue == ExportContactFileTypes.csv) {
                  isSuccess = await _exportCSV(exportHelper);
                }
                setState(() {
                  isExporting = false;
                });
                if (isSuccess) {
                  Get.to(() => const ContactBackupStepSendDevice());
                }
              },
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 24.w),
          alignment: Alignment.center,
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64.r),
              color: isExporting ? Colors.grey : Colors.black,
            ),
            alignment: Alignment.center,
            child: isExporting
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement,
                    ),
                  )
                : Text(
                    '导出',
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

  Future<bool?> alertDialog(title, content) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  child: const Text(
                    '取消',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
              TextButton(
                child: const Text(
                  '确定',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<bool> _exportXLSX(ExportHelper exportHelper) async {
    bool ret = false;
    String result = await exportHelper.exportContactsToExcel();
    if (kDebugMode) {
      print(result);
    }
    if (result == 'An Error Occurred :(') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      ret = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Excel file stored at : ' + result),
        ),
      );
    }

    return ret;
  }

  Future<bool> _exportPDF(ExportHelper exportHelper) async {
    bool ret = false;
    String result = await exportHelper.exportContactsToPDF();
    if (kDebugMode) {
      print(result);
    }
    if (result == 'An Error Occurred :(') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      ret = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF file stored at : $result'),
        ),
      );
    }
    return ret;
  }

  Future<bool> _exportCSV(ExportHelper exportHelper) async {
    bool ret = false;
    String result = await exportHelper.exportContactsToCSV();
    if (result == 'An Error Occurred :(') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      ret = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV file stored at : $result'),
        ),
      );
    }
    return ret;
  }
}
