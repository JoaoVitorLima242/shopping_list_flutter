import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_item.dart';

class YourGroceryScreen extends StatelessWidget {
  const YourGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Grocery')),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                color: groceryItems[index].category.color,
                shape: BoxShape.circle),
          ),
          trailing: Text(groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
