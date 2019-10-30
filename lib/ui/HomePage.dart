import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/contact_helper.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();

    // testando implemenatção do bd
//    Contact c = Contact();
//    c.name = "Allef";
//    c.img = "AllefImage";
//    c.phone = "169919263895";
//    c.email= "allefsousa_1@hotmail.com";
//    helper.saveContact(c);

    // buscando contatos
  helper.getAllContacts().then((list){
    print(list);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
