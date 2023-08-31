import 'package:flutter/material.dart';
import 'package:shopping_list/features/new_item/widgets/new_item_form.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: NewItemForm(),
      ),
    );
  }
}
