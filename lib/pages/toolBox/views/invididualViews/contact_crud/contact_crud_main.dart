import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_crud/contact_crud_detail.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactCrudMain extends StatefulWidget {
  ContactCrudMain({Key? key}) : super(key: key);

  @override
  _ContactCrudMainState createState() => _ContactCrudMainState();
}

class _ContactCrudMainState extends State<ContactCrudMain> {
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String? flattenPhoneNumber(String? phoneStr) {
    return phoneStr?.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<AppContact> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return new AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String? searchTermFlatten = flattenPhoneNumber(searchTerm);
        String? contactName = contact.info.displayName?.toLowerCase();
        bool? nameMatches = contactName?.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten != null || searchTermFlatten!.isEmpty) {
          return false;
        }

        var phone = contact.info.phones?.firstWhere((phn) {
          String? phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened!.contains(searchTermFlatten);
        }, orElse: () => Item());

        return phone?.value != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist =
        ((isSearching == true && contactsFiltered.length > 0) ||
            (isSearching != true && contacts.length > 0));
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Crud"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () async {
          try {
            Contact contact = await ContactsService.openContactForm();
            if (contact != null) {
              getAllContacts();
            }
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
              case null:
                print(e.toString());
            }
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                height: 50, // 设置高度
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.primaryText)),
                ),
              ),
            ),
            contactsLoaded == true
                ? // if the contacts have not been loaded yet
                listItemsExist == true
                    ? // if we have contacts to show
                    ContactsList(
                        reloadContacts: () {
                          getAllContacts();
                        },
                        contacts:
                            isSearching == true ? contactsFiltered : contacts,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          isSearching
                              ? 'No search results to show'
                              : 'No contacts exist',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ))
                : Container(
                    // still loading contacts
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class ContactsList extends StatelessWidget {
  final List<AppContact> contacts;
  Function() reloadContacts;
  ContactsList({Key? key, required this.contacts, required this.reloadContacts})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts[index];

          return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ContactDetails(
                          contact,
                          onContactDelete: (AppContact _contact) {
                            reloadContacts();
                            Navigator.of(context).pop();
                          },
                          onContactUpdate: (AppContact _contact) {
                            reloadContacts();
                          },
                        )));
              },
              title: Text(contact.info.displayName ?? ''),
              subtitle: Text(contact.info.phones != null
                  ? (contact.info.phones!.isNotEmpty
                      ? contact.info.phones!.elementAt(0).value!
                      : '')
                  : ''),
              leading: ContactAvatar(contact, 36));
        },
      ),
    );
  }
}

class AppContact {
  final Color color;
  Contact info;

  AppContact({Key? key, required this.color, required this.info});
}
