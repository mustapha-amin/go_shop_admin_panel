import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:sizer/sizer.dart';

import '../responsive.dart';
import '../services/utils.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.valueKey,
    this.isPrice = false,
  });

  final TextEditingController controller;
  final String valueKey;
  final String hint;
  bool? isPrice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: (Responsive.isPC(context) || Responsive.isTablet(context))
          ? 20.w
          : size.width,
      height: 12.h,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        key: ValueKey(valueKey),
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        style: kTextStyle(15, context),
      ),
    );
  }
}
