import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_item.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_tile.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) =>
          GroceryTile(groceryItem: groceryItems[index]),
    );
  }
}
