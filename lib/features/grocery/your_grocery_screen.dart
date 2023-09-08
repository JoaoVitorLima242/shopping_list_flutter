import 'package:flutter/material.dart';
import 'package:shopping_list/api/grocery_items_api.dart';
import 'package:shopping_list/features/grocery/widgets/empty_screen_content.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_list.dart';
import 'package:shopping_list/features/new_item/new_item_screen.dart';
import 'package:shopping_list/models/grocery_item.dart';

import 'package:http/http.dart' as http;

class YourGroceryScreen extends StatefulWidget {
  const YourGroceryScreen({super.key});

  @override
  State<YourGroceryScreen> createState() => _YourGroceryScreenState();
}

class _YourGroceryScreenState extends State<YourGroceryScreen> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final loadedItems = await GroceryItemApi().getGroceryItemsRequest();

    setState(() {
      _groceryItems = loadedItems;
    });
  }

  void _goToNewItemScreen() async {
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItemScreen()),
    );

    _loadItems();
  }

  void _removeItem(GroceryItem groceryItem) {
    setState(() {
      _groceryItems.remove(groceryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenContent = const EmptyScreenContent();

    if (_groceryItems.isNotEmpty) {
      screenContent = GroceryList(
        groceryItems: _groceryItems,
        onRemoveItem: _removeItem,
      );
    }

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
      body: screenContent,
    );
  }
}
