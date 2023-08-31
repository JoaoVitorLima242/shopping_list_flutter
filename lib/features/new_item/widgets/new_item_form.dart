import 'package:flutter/material.dart';
import 'package:shopping_list/features/new_item/utils/validators.dart';
import 'package:shopping_list/features/new_item/widgets/categories_dropdown.dart';

class NewItemForm extends StatelessWidget {
  NewItemForm({super.key});

  final _formKey = GlobalKey<FormState>();

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _saveItem() {
    _formKey.currentState!.validate();
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
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Quantity'),
                  ),
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (isValueNotEmptyAndPositiveNumber(value)) {
                      return "Must be a valid, and positive number.";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CategoriesDropdown(
                  onChanged: (value) {},
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
