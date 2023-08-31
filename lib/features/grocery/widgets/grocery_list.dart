import 'package:flutter/material.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_tile.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key, required this.groceryItems});

  final List<GroceryItem> groceryItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) =>
          GroceryTile(groceryItem: groceryItems[index]),
    );
  }
}
