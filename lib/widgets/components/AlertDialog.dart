import 'package:flutter/material.dart';

Future<bool?> showAlertDialog(
    BuildContext context, String title, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
