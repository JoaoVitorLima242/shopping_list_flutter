import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/api/grocery_items_api.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/features/new_item/utils/validators.dart';
import 'package:shopping_list/features/new_item/widgets/categories_dropdown.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItemForm extends StatefulWidget {
  const NewItemForm({super.key});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _enteredName = "";
  int _enteredQuantity = 1;
  Category _enteredCategory = categories[Categories.vegetables]!;
  bool _isSending = false;

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      final response = await GroceryItemApi().createGroceryItemRequest(
        _enteredName,
        _enteredQuantity,
        _enteredCategory.title,
      );

      final String id = json.decode(response.body)['name'];

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(GroceryItem(
        id: id,
        category: _enteredCategory,
        name: _enteredName,
        quantity: _enteredQuantity,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
            validator: (value) {
              if (isValueNotEmpty(value)) {
                return "Must be between 1 and 50 characters.";
              }

              return null;
            },
            onSaved: (value) {
              _enteredName = value!;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Quantity'),
                  ),
                  initialValue: _enteredQuantity.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (isValueNotEmptyAndPositiveNumber(value)) {
                      return "Must be a valid, and positive number.";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _enteredQuantity = int.parse(value!);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CategoriesDropdown(
                  value: _enteredCategory,
                  onChanged: (value) {
                    _enteredCategory = value!;
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isSending ? null : _resetForm,
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: _isSending ? null : _saveItem,
                child: _isSending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Add item'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
