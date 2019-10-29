import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//database name and colums
final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "idemailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper {
  static final ContactHelper _instace = ContactHelper.internal();

  factory ContactHelper() => _instace;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }


  //Init Database
  Future<Database> initDb() async {
    final databasePatch = await getDatabasesPath();
    final path = join(databasePatch, "contacts.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)");
    });
  }
   // salvando os dados em um BD
  Future<Contact> saveContact(Contact contact) async{
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  // buscando um contato pelo id
  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,columns: [idColumn,
      nameColumn,emailColumn,phoneColumn,imgColumn], where: "$idColumn = ?", whereArgs: [id]);
    if (maps.length > 0){
      return  Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }

  //deletando um contato
  Future<int> deleteContact(int id) async{
    Database dbContact = await db;
   return await dbContact.delete(contactTable, where: "$idColumn = ?",whereArgs: [id]);
  }

  // atualizando um contato
  Future<int> updateContact(Contact contact)async{
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),where: "$idColumn = ?",whereArgs: [contact.id] );
  }

  // Buscando todos os contatos
  Future<List> getAllContact() async{
    Database dbContact = await db;
    List listMap =  await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> list = List();
    for (Map m in listMap){
      list.add(Contact.fromMap(m));
    }
    return list;
  }


  Future<int> getNumber()async{
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable") );
  }

  //fechando DB
  Future close() async{
    Database dbContact = await db;
    dbContact.close();
  }




}


// Model
class Contact {
  int id;
  String name;
  String email;
  String phone;
  String image;

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: image
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact (id: $id , name: $name, email:$email,phone: $phone,Image:$image )";
  }
}
