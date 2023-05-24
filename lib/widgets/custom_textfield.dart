import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';

import '../responsive.dart';
import '../services/utils.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.productNameController,
    required this.valueKey,
    this.isPrice = false,
  });

  final TextEditingController productNameController;
  final String valueKey;
  final String hint;
  bool? isPrice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: (Responsive.isPC(context) || Responsive.isTablet(context))
          ? size.width / 4
          : size.width,
      height: size.height / 12,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        key: ValueKey(valueKey),
        textAlignVertical: TextAlignVertical.center,
        controller: productNameController,
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
