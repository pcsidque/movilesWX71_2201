import 'package:flutter/material.dart';

void main() {
  runApp(MyStatefullApp());
}

class MyStatelessApp extends StatelessWidget {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ejm de StatelessWidget"),
        ),
        body: Center(
          child: Text(
              counter.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: (){
            counter++;
            print(counter);//para imprimir en consola
          },
        ),

      ),
    );
  }
}

class MyStatefullApp extends StatefulWidget {
  @override
  State<MyStatefullApp> createState() => _MyStatefullAppState();
}

class _MyStatefullAppState extends State<MyStatefullApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ejm de StatefullWidget"),
        ),
        body: Center(
          child: Text(
            counter.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: (){
            counter++;
            print(counter);//para imprimir en consola
            setState(() {
            });
          },
        ),

      ),
    );
  }
}
