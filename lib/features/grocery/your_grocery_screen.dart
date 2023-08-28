import 'package:flutter/material.dart';
import 'package:shopping_list/features/grocery/widgets/grocery_list.dart';

class YourGroceryScreen extends StatelessWidget {
  const YourGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Grocery')),
      body: const GroceryList(),
    );
  }
}
