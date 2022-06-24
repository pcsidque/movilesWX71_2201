import 'package:flutter/material.dart';
import 'package:app_my_shopping/utils/dbhelper.dart';
import 'package:app_my_shopping/models/shopping_list.dart';
import 'package:app_my_shopping/models/list_items.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  _ItemsScreenState(this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: Container(),
    );
  }
}
