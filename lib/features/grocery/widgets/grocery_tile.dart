import 'package:flutter/material.dart';
import 'package:shopping_list/common_widgets/colored_circle.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.groceryItem});
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(groceryItem.name),
      leading: ColoredCircle(groceryItem.category.color),
      trailing: Text(groceryItem.quantity.toString()),
    );
  }
}
