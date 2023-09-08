import 'package:flutter/material.dart';

class TextScreenContent extends StatelessWidget {
  const TextScreenContent(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
