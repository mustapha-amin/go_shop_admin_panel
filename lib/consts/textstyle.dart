import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle kTextStyle(double size,
    {bool? isBold, bool? scaledPixels, Color? color}) {
  return GoogleFonts.gabarito(
    fontSize: scaledPixels == null ? size : size.sp,
    color: color ?? Colors.black,
    fontWeight: isBold != null && isBold ? FontWeight.bold : FontWeight.normal,
  );
}
