import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:testdrive/MVP/Contacts/data/contact_data.dart';
import 'package:testdrive/MVP/Contacts/presenter/contact_presenter.dart';
import 'package:testdrive/MVP/Contacts/view/contact_detail_view.dart';


class ContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactListState();

}

class _ContactListState extends State<ContactList> implements ContactListViewContract {
  ContactListPresenter _presenter;
  List<Contact> _contacts;
  bool _isSearching;

  _ContactListState() {
    _presenter = new ContactListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if(_isSearching) {
      widget = new Center(
        child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right:16.0),
        ),

      );
    } else {
      widget = new ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Contact List"),
      ),
      body: widget,
    );
  }

  @override
  void onLoadContactsComplete(List<Contact> items) {
    setState(() {
      _contacts = items;
      _isSearching = false;
    });
  }

  @override
  void onLoadContactsError() {
    // TODO: implement onLoadContactsError
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts.map((contact) => new _ContactListItem(contact: contact, onTap: () {
      _showContactPage(context, contact);
    },
    )).toList();
  }

  void _showContactPage(BuildContext context, Contact contact) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ContactPage(contact)));
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem({@required Contact contact, @required GestureTapCallback onTap}): super(
    title: new Text(contact.fullName),
    subtitle: new Text(contact.email),
    leading: new CircleAvatar(
      child: new Text(contact.fullName[0]),
    ),
    onTap: onTap
  );
}