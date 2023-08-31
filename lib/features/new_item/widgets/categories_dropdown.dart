import 'package:flutter/material.dart';
import 'package:shopping_list/common_widgets/colored_circle.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';

class CategoriesDropdown extends StatelessWidget {
  const CategoriesDropdown({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final void Function(Category?)? onChanged;
  final Category value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Must select a category';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Category'),
      ),
      items: [
        for (final category in categories.entries)
          DropdownMenuItem(
            value: category.value,
            child: Row(
              children: [
                ColoredCircle(category.value.color),
                const SizedBox(
                  width: 6,
                ),
                Text(category.value.title)
              ],
            ),
          )
      ],
    );
  }
}
