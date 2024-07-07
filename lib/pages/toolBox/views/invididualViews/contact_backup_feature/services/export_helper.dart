import 'dart:io' show Directory, File;

import 'package:contacts_service/contacts_service.dart';

//FOR SAVING FILES
import 'package:external_path/external_path.dart' show ExternalPath;

//FOR EXCEL
import 'package:excel/excel.dart'
    show CellIndex, CellValue, Data, Excel, TextCellValue;
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature/services/contact_export_helper.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup_feature/services/pdf_helper.dart';

//FOR PDF
import 'package:pdf/pdf.dart' show PdfColors;
import 'package:pdf/widgets.dart'
    show
        Document,
        MultiPage,
        Table,
        TableBorder,
        Font,
        BorderStyle,
        ThemeData,
        TableCellVerticalAlignment;

//FOR DEBUGGING
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart' show rootBundle;

//FOR CSV
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportHelper {
  List<Contact> contactsList;
  ContactExportHelper helper = ContactExportHelper();

  ExportHelper({required this.contactsList});

  Future<String> exportContactsToExcel() async {
    Excel excel = Excel.createExcel();
    excel['Sheet1'].insertRow(0);
    Data cellName = excel['Sheet1']
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
    cellName.value = TextCellValue('Name');
    Data cellPhone = excel['Sheet1']
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0));
    cellPhone.value = TextCellValue('Phones');
    Data cellEmail = excel['Sheet1']
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0));
    cellEmail.value = TextCellValue('Emails');
    Data cellAddress = excel['Sheet1']
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0));
    cellAddress.value = TextCellValue('Addresses');
    int rowIndex = 1;
    for (Contact contact in contactsList) {
      Data cellName = excel['Sheet1']
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
      cellName.value = TextCellValue(helper.getContactName(contact));
      Data cellPhone = excel['Sheet1']
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
      cellPhone.value = TextCellValue(helper.getPhonesList(contact.phones));
      Data cellEmail = excel['Sheet1']
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
      cellEmail.value = TextCellValue(helper.getEmailList(contact.emails));
      Data cellAddress = excel['Sheet1']
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
      cellAddress.value =
          TextCellValue(helper.getAddressList(contact.postalAddresses));
      rowIndex++;
    }
    var bytes = excel.save();
    try {
      String path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      File('$path/Contacts.xlsx')
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes!);
      return path;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'An Error Occurred :(';
    }
  }

  Future<String> exportContactsToPDF() async {
    PdfHelper pdfHelper = PdfHelper();
    try {
      final pdf = Document();
      pdf.addPage(
        MultiPage(
          maxPages: 100,
          theme: ThemeData.withFont(
            base: Font.ttf(
                await rootBundle.load("assets/fonts/weiruanyahei.ttf")),
            bold: Font.ttf(
                await rootBundle.load("assets/fonts/weiruanyahei.ttf")),
            italic: Font.ttf(
                await rootBundle.load("assets/fonts/weiruanyahei.ttf")),
            boldItalic: Font.ttf(
                await rootBundle.load("assets/fonts/weiruanyahei.ttf")),
          ),
          header: (context) => pdfHelper.getPdfHeader(context),
          footer: (context) => pdfHelper.getPdfFooter(context),
          build: (context) {
            return [
              Table(
                border: TableBorder.all(color: PdfColors.black, width: 1.0),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: pdfHelper.getPDFContactsList(contactsList),
              ),
            ];
          },
        ),
      );

      String path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String filePath = '$path/Contacts.pdf';
      File pdfFile = File(filePath);

      await pdfFile.writeAsBytes(await pdf.save());
      return filePath;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'An Error Occurred :(';
    }
  }

  Future<String> exportContactsToCSV() async {
    List<List<dynamic>> rows = [];
    List<dynamic> firstRow = ['Name', 'Phone', 'Address', 'Email'];
    rows.add(firstRow);
    for (Contact contact in contactsList) {
      List<dynamic> cnt = [];
      cnt.add(
        helper.getContactName(contact),
      );
      cnt.add(
        helper.getPhonesList(contact.phones),
      );
      cnt.add(
        helper.getAddressList(contact.postalAddresses),
      );
      cnt.add(
        helper.getEmailList(contact.emails),
      );
      rows.add(cnt);
    }

    try {
      String csv = const ListToCsvConverter().convert(rows);
      String path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS,
      );
      String filePath = '$path/Contacts.csv';
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      if (status.isGranted) {
        File csvFile = File(filePath);
        if (!csvFile.existsSync()) {
          csvFile.createSync(recursive: true);
        }
        csvFile.writeAsString(csv);
        return filePath;
      } else {
        return "cancelled";
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'An Error Occurred :(';
    }
  }
}
