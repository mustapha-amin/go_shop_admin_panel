import 'package:flutter/material.dart';

bool isPCorTablet(BuildContext context) {
  return MediaQuery.of(context).size.width > 800;
}
