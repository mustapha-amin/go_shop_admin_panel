import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 300),
    ),
  );
}
