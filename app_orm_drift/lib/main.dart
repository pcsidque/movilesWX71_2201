import 'package:flutter/material.dart';
import 'package:app_orm_drift/ui/listUser.dart';
import 'package:app_orm_drift/database/database.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: listUser(),
      ),
    );
  }
}