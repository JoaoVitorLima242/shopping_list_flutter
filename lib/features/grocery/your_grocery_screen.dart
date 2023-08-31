import 'package:flutter/material.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_list.dart';
import 'package:shopping_list/features/new_item/new_item_screen.dart';

class YourGroceryScreen extends StatefulWidget {
  const YourGroceryScreen({super.key});

  @override
  State<YourGroceryScreen> createState() => _YourGroceryScreenState();
}

class _YourGroceryScreenState extends State<YourGroceryScreen> {
  void _goToNewItemScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewItemScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(
            onPressed: _goToNewItemScreen,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const GroceryList(),
    );
  }
}
