import 'dart:math';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/pages/toolBox/components/wechat_style_searchBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactBackup extends StatefulWidget {
  const ContactBackup({super.key});

  @override
  _ContactBackupState createState() => _ContactBackupState();
}

class _ContactBackupState extends State<ContactBackup> {
  List<Contact> contacts = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request().then((_) {
        fetchContacts();
      }).catchError((error) {
        print("Failed to request contact permission: $error");
      });
    }
  }

  void fetchContacts() async {
    contacts = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: Column(
          children: [
            WechatSearchBar(
              onEdit: () {
                //
                print('edit action ....');
              },
              onCancel: () {
                print('cancel action ....');
              },
            ),
            Expanded(
              // wrap in Expanded
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 30.h,
                            width: 30.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Colors.white.withOpacity(0.1),
                                  offset: const Offset(-3, -3),
                                ),
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: const Offset(3, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(6.r),
                              color: Color(0xff262626),
                            ),
                            child: Text(
                              contacts[index].displayName != null &&
                                      contacts[index].displayName!.isNotEmpty
                                  ? contacts[index].displayName![0]
                                  : "NaN",
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          title: Text(
                            contacts[index].displayName != null &&
                                    contacts[index].displayName!.isNotEmpty
                                ? contacts[index].displayName!
                                : "No displayName",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color.fromARGB(255, 8, 8, 8),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            contacts[index].phones != null &&
                                    contacts[index].phones!.isNotEmpty
                                ? contacts[index].phones![0].value!
                                : "No phone",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xffC4c4c4),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          horizontalTitleGap: 12.w,
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
