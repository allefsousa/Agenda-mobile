import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/contact_helper.dart';
class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with SingleTickerProviderStateMixin {

  Contact _editContact;
  @override
  void initState() {
    super.initState();
    if(widget.contact == null){
      _editContact = Contact();
    }else{
      _editContact = Contact.fromMap(widget.contact.toMap());
    }


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
