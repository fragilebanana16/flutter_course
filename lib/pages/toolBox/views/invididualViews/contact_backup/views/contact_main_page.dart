import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'
    show PlatformFile, FilePicker, FileType;
import 'package:contacts_service/contacts_service.dart' show ContactsService;
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup/services/export_helper.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup/util/contact_constants.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup/views/Import_from_excel.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactImExportView extends StatefulWidget {
  const ContactImExportView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactImExportView> {
  fileTypes? _groupValue = fileTypes.xlsx;
  String filePath = '', fileName = '';
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts to Im&Export'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Flexible(
                  child: RadioListTile<fileTypes>(
                    title: const Text(
                      'XLSX',
                      style: TextStyle(fontSize: 12),
                      textDirection: TextDirection.ltr,
                    ),
                    value: fileTypes.xlsx,
                    groupValue: _groupValue,
                    onChanged: (fileTypes? val) => setState(() {
                      _groupValue = val;
                    }),
                  ),
                ),
                Flexible(
                  child: RadioListTile<fileTypes>(
                    title: const Text(
                      'PDF',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: fileTypes.pdf,
                    groupValue: _groupValue,
                    onChanged: (fileTypes? val) => setState(() {
                      _groupValue = val;
                    }),
                  ),
                ),
                Flexible(
                  child: RadioListTile<fileTypes>(
                    title: const Text(
                      'CSV',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: fileTypes.csv,
                    groupValue: _groupValue,
                    onChanged: (fileTypes? val) => setState(() {
                      _groupValue = val;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () async {
                await Permission.contacts.request();
                ExportHelper exportHelper = ExportHelper(
                    contactsList: await ContactsService.getContacts());
                if (_groupValue == fileTypes.xlsx) {
                  _exportXLSX(exportHelper);
                } else if (_groupValue == fileTypes.pdf) {
                  _exportPDF(exportHelper);
                } else if (_groupValue == fileTypes.csv) {
                  _exportCSV(exportHelper);
                }
              },
              child: const Text('Export Contacts'),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: ListTile(
                title: const Text('Select XLSX file'),
                trailing: const Icon(Icons.note_add_outlined),
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx'],
                    allowMultiple: false,
                  );
                  if (result == null) return;
                  file = result.files.first;
                  print(file!.path);
                  filePath = file!.path!;
                  setState(() {
                    fileName = file!.name;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Selected XLSX File : $fileName',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                if (file != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImportFromExcel(
                        file: file!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Invalid File Selection',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
              },
              child: const Text('Import Contacts'),
            ),
          ],
        ),
      ),
    );
  }

  void _exportXLSX(ExportHelper exportHelper) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Excel file stored at : ' + result),
        ),
      );
    }
  }

  void _exportPDF(ExportHelper exportHelper) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF file stored at : $result'),
        ),
      );
    }
  }

  void _exportCSV(ExportHelper exportHelper) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV file stored at : $result'),
        ),
      );
    }
  }
}
