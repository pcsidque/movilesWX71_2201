import 'package:flutter/material.dart';
import 'package:app_orm_drift/database/database.dart';
import 'package:drift/drift.dart' as dr;
import 'package:provider/provider.dart';

class newUser extends StatefulWidget {
  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  late AppDatabase appDatabase;
  late TextEditingController txtNombre;
  late TextEditingController txtCorreo;

  @override
  void initState() {
    super.initState();
    txtNombre = TextEditingController();
    txtCorreo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtNombre,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Ingrese nombre"
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: txtCorreo,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Ingrese correo"
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: (){
                  appDatabase.insertUser(UsersCompanion(
                    nombre: dr.Value(txtNombre.text),
                    correo: dr.Value(txtCorreo.text),
                  ))
                      .then((value) {
                    Navigator.pop(context, true);
                  });
                }, child: Text("Grabar usuario...")
            )
          ],
        ),
      ),
    );
  }
}