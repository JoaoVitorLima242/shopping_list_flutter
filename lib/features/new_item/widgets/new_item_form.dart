import 'package:flutter/material.dart';
import 'package:shopping_list/features/new_item/widgets/categories_dropdown.dart';

class NewItemForm extends StatelessWidget {
  const NewItemForm({super.key});

  bool _isValueNotEmpty(String? value) {
    return (value == null || value.isEmpty || value.trim().length <= 1);
  }

  bool _isValueNotEmptyAndPositiveNumber(String? value) {
    return (value == null ||
        value.isEmpty ||
        int.tryParse(value) == null ||
        int.tryParse(value)! <= 1);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
            validator: (value) {
              if (_isValueNotEmpty(value)) {
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
                  validator: (value) {
                    if (_isValueNotEmptyAndPositiveNumber(value)) {
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
                onPressed: () {},
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add item'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
