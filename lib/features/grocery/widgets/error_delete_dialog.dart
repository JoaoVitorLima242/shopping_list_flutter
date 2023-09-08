import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error deleting'),
      content: const Text('Please try again later.'),
      actions: [
        TextButton(
          onPressed: () => _onClose(context),
          child: const Text('Okay'),
        )
      ],
    );
  }
}
