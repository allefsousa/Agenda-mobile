import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/contact_helper.dart';

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
    helper.getAllContacts().then((list){
      setState(() {
        contact = list;
      });
    });
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
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(itemBuilder: (context,index){

      },
        itemCount: contact.length,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
