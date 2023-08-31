import 'package:flutter/material.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_list.dart';
import 'package:shopping_list/features/new_item/new_item_screen.dart';
import 'package:shopping_list/models/grocery_item.dart';

class YourGroceryScreen extends StatefulWidget {
  const YourGroceryScreen({super.key});

  @override
  State<YourGroceryScreen> createState() => _YourGroceryScreenState();
}

class _YourGroceryScreenState extends State<YourGroceryScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _goToNewItemScreen() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItemScreen()),
    );
    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
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
      body: GroceryList(groceryItems: _groceryItems),
    );
  }
}
