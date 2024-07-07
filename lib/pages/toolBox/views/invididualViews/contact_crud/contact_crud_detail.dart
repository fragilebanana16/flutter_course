import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_crud/contact_crud_main.dart';

class ContactDetails extends StatefulWidget {
  ContactDetails(this.contact,
      {required this.onContactUpdate, required this.onContactDelete});

  final AppContact contact;
  final Function(AppContact) onContactUpdate;
  final Function(AppContact) onContactDelete;
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> actions = <String>['Edit', 'Delete'];

    showDeleteConfirmation() {
      Widget cancelButton = TextButton(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget deleteButton = TextButton(
        child: Text('Delete'),
        onPressed: () async {
          await ContactsService.deleteContact(widget.contact.info);
          widget.onContactDelete(widget.contact);
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text('Delete contact?'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[cancelButton, deleteButton],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    onAction(String action) async {
      switch (action) {
        case 'Edit':
          try {
            Contact updatedContact =
                await ContactsService.openExistingContact(widget.contact.info);
            setState(() {
              widget.contact.info = updatedContact;
            });
            widget.onContactUpdate(widget.contact);
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
              case null:
                print(e.toString());
            }
          }
          break;
        case 'Delete':
          showDeleteConfirmation();
          break;
      }
      print(action);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Center(child: ContactAvatar(widget.contact, 100)),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        onSelected: onAction,
                        itemBuilder: (BuildContext context) {
                          return actions.map((String action) {
                            return PopupMenuItem(
                              value: action,
                              child: Text(action),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  title: Text("Name"),
                  trailing: Text(widget.contact.info.givenName ?? ""),
                ),
                ListTile(
                  title: Text("Family name"),
                  trailing: Text(widget.contact.info.familyName ?? ""),
                ),
                Column(
                  children: <Widget>[
                    ListTile(title: Text("Phones")),
                    Column(
                      children: (widget.contact.info.phones ?? [])
                          .map(
                            (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                title: Text(i.label ?? ""),
                                trailing: Text(i.value ?? ""),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

LinearGradient getColorGradient(Color color) {
  var baseColor = color as dynamic;
  Color color1 = baseColor[800];
  Color color2 = baseColor[400];
  return LinearGradient(colors: [
    color1,
    color2,
  ], begin: Alignment.bottomLeft, end: Alignment.topRight);
}

class ContactAvatar extends StatelessWidget {
  ContactAvatar(this.contact, this.size);
  final AppContact contact;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle, gradient: getColorGradient(contact.color)),
        child: (contact.info.avatar != null &&
                contact.info.avatar != null &&
                contact.info.avatar!.length > 0)
            ? CircleAvatar(
                backgroundImage: MemoryImage(contact.info.avatar!),
              )
            : CircleAvatar(
                child: Text(contact.info.initials(),
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent));
  }
}
