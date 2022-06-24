import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_my_shopping/models/shopping_list.dart';
import 'package:app_my_shopping/models/list_items.dart';
import 'package:sqflite/sql.dart';

class DbHelper{
  final int version = 1; //opc.
  Database? db;

  //codigo q controla q solo se abra 1 instancia de la BD
  static final DbHelper dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper(){
    return dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(),
          'shopp_v3.db'),
          onCreate: (database, version) {
            database.execute(
                'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
            database.execute(
                'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, '
                    'name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))');
          }, version: version
      );
    }
    return db!;
  }

  Future testDb() async{
    db = await openDb();

    await db!.execute('INSERT INTO lists(name, priority) VALUES("Memorias", 3)');
    await db!.execute('INSERT INTO items(idList, name, quantity, note) VALUES(1, "Memoria USB", "3 cajas", "Micro-memorias")');

    List lists = await db!.rawQuery('SELECT * FROM lists');
    List items = await db!.rawQuery('SELECT * FROM items');

    print(lists[0]);
    print(items[0]);
  }

  //insert Lists
  Future<int> insertList(ShoppingList list) async{
    int id = await this.db!.insert('lists',
    list.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //insert items
  Future<int> insertItem(ListItem item) async {
    int id = await this.db!.insert('items',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace); //super import.
    return id;
  }

  //listar tabla "lists"
  Future<List<ShoppingList>> getLists() async{
    final List<Map<String, dynamic>> maps = await db!.query('lists');

    return List.generate(maps.length, (i){
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }

  //metodo para mostrar la tabla "items" a traves del id de "lists"
  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps = await db!.query('items', where: 'idList = ?',
        whereArgs: [idList]);

    return List.generate(maps.length, (i) {
      return ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['name'],
        maps[i]['quantity'],
        maps[i]['note'],
      );
    });
  }
}