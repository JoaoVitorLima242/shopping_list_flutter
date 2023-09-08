import 'package:flutter/material.dart';
import 'package:shopping_list/api/grocery_items_api.dart';
import 'package:shopping_list/features/grocery/widgets/error_delete_dialog.dart';
import 'package:shopping_list/features/grocery/widgets/text_screen_content.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_list.dart';
import 'package:shopping_list/features/new_item/new_item_screen.dart';
import 'package:shopping_list/models/grocery_item.dart';

class YourGroceryScreen extends StatefulWidget {
  const YourGroceryScreen({super.key});

  @override
  State<YourGroceryScreen> createState() => _YourGroceryScreenState();
}

class _YourGroceryScreenState extends State<YourGroceryScreen> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    try {
      final loadedItems = await GroceryItemApi().getGroceryItemsRequest();

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch data. Please try again later';
      });
    }
  }

  void _goToNewItemScreen() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItemScreen()),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem groceryItem) async {
    final index = _groceryItems.indexOf(groceryItem);

    setState(() {
      _groceryItems.remove(groceryItem);
    });

    final respose =
        await GroceryItemApi().deleteGroceryItemRequest(groceryItem.id);

    if (respose.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, groceryItem);
      });

      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (ctx) => const ErrorDialog(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenContent = const TextScreenContent('No items added yet.');

    if (_error.isNotEmpty) {
      screenContent = TextScreenContent(_error);
    }

    if (_isLoading) {
      screenContent = const Center(child: CircularProgressIndicator());
    }

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
