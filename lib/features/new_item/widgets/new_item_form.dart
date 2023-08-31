import 'package:flutter/material.dart';

class NewItemForm extends StatelessWidget {
  const NewItemForm({super.key});

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
              return 'Demo...';
            },
          ),
        ],
      ),
    );
  }
}
