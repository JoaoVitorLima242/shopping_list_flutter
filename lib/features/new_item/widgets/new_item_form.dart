import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/features/new_item/utils/validators.dart';
import 'package:shopping_list/features/new_item/widgets/categories_dropdown.dart';
import 'package:shopping_list/models/category.dart';

import 'package:http/http.dart' as http;

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

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https(
        'shopping-list-flutter-a2db5-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _enteredCategory.title,
          },
        ),
      );

      print(response.statusCode);
      print(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop();
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
                onPressed: _resetForm,
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Add item'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
