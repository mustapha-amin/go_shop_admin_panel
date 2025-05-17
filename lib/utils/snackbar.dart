import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 700),
    ),
  );
}
