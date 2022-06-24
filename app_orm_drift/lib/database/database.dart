import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//importante
part 'database.g.dart';

class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().named('nombre')();
  TextColumn get correo => text()();
}

LazyDatabase openConnection(){
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbwx71.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables:[Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  //creamos el C R U D
  //insertar
  Future<int> insertUser(UsersCompanion userCompanion) async {
    return await into(users).insert(userCompanion);
  }

  //listar
  Future<List<User>> getListUsers() async {
    return await select(users).get();
  }

  //update
  Future<bool> updateUser(UsersCompanion usersCompanion) async {
    return await update(users).replace(usersCompanion);
  }

  //delete
  Future<int> deleteUser(UsersCompanion usersCompanion) async {
    return await delete(users).delete(usersCompanion);
  }
}