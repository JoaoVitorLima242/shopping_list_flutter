import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/features/new_item/utils/validators.dart';
import 'package:shopping_list/features/new_item/widgets/categories_dropdown.dart';
import 'package:shopping_list/models/category.dart';

class NewItemForm extends StatefulWidget {
  const NewItemForm({super.key});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _enteredName = "";

  String _enteredQuantity = "1";

  Category _enteredCategory = categories[Categories.vegetables]!;

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredName);
      print(_enteredQuantity);
      print(_enteredCategory);
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
                  initialValue: _enteredQuantity,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (isValueNotEmptyAndPositiveNumber(value)) {
                      return "Must be a valid, and positive number.";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _enteredQuantity = value!;
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
