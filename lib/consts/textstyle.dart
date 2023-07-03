import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

kTextStyle(double size, BuildContext context,
    {bool? isBold, bool? scaledPixels}) {
  return GoogleFonts.lato(
    fontSize: scaledPixels == null ? size : size.sp,
    // ignore: unnecessary_null_comparison
    fontWeight: isBold != null && isBold ? FontWeight.bold : FontWeight.normal,
  );
}
