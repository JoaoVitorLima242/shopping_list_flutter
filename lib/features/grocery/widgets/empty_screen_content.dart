import 'package:flutter/material.dart';

class EmptyScreenContent extends StatelessWidget {
  const EmptyScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No items added yet.',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
