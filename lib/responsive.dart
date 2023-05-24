import 'package:flutter/material.dart';

class Responsive {
  static const double _breakpointSmall = 576.0;
  static const double _breakpointMedium = 768.0;
  static const double _breakpointLarge = 992.0;
  static const double _breakpointExtraLarge = 1200.0;

  static bool isTablet(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= _breakpointMedium && screenWidth < _breakpointLarge;
  }

  static bool isPC(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= _breakpointLarge;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _breakpointSmall;
  }
}
