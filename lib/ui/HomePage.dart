import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/contact_helper.dart';
import 'package:flutter_app/helpers/contact_helper.dart' as prefix0;
import 'package:flutter_app/ui/contact_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contact = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: _contactCard(context, index))));
//        return _contactCard(context, index);
        },
        itemCount: contact.length,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contact[index].img != null
                            ? FileImage(File(contact[index].img))
                            : AssetImage("images/person.png"))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contact[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contact[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contact[index].phone ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showContactPage(contact: contact[index]);
      },
    );
  }

  // router navigation para nova tela
  void _showContactPage({Contact contact}) async { // parametro opcional
    final reacContact = await  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact,)));
    if (reacContact != null){
      if(contact != null){
       await helper.updateContact(reacContact); // atualizando um contato
      }else{
        await helper.saveContact(reacContact);  // salvando um contato novo
      }
      _getAllContacts();
    }
  }
  void _getAllContacts(){ // buscando os contatos
    helper.getAllContacts().then((list) {
      setState(() {
        contact = list;
      });
    });
  }
}
