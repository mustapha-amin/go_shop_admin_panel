import 'package:flutter/material.dart';

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width > 600 &&
      MediaQuery.of(context).size.width < 1000;
}

bool isPC(BuildContext context) {
  return MediaQuery.of(context).size.width > 1000;
}

bool isPCorTablet(BuildContext context) {
  return isPC(context) || isTablet(context);
}
