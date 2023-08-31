import 'package:flutter/material.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_tile.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({
    super.key,
    required this.groceryItems,
    required this.onRemoveItem,
  });

  final List<GroceryItem> groceryItems;
  final void Function(GroceryItem groceryItem) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          onRemoveItem(groceryItems[index]);
        },
        key: ValueKey(groceryItems[index].id),
        child: GroceryTile(
          groceryItem: groceryItems[index],
        ),
      ),
    );
  }
}
