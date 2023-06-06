import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../consts/textstyle.dart';
import '../global_products.dart';
import '../services/utils.dart';
import 'custom_textfield.dart';

class InputFields extends StatefulWidget {
  TextEditingController? priceController,
      productNameController,
      descriptionController;
  Category? selectedCategory;

  InputFields({
    this.priceController,
    this.productNameController,
    this.descriptionController,
    this.selectedCategory,
    super.key,
  });

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hint: 'Product',
          controller: widget.productNameController!,
          valueKey: 'product',
        ),
        addVerticalSpacing(10),
        CustomTextField(
          hint: 'Price',
          controller: widget.priceController!,
          valueKey: 'price',
          isPrice: true,
        ),
        addVerticalSpacing(10),
        DescriptionField(
          descriptionController: widget.descriptionController,
        ),
      ],
    );
  }
}

class DescriptionField extends StatefulWidget {
  TextEditingController? descriptionController;
  DescriptionField({this.descriptionController, super.key});

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 100.w,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        key: const ValueKey('description'),
        controller: widget.descriptionController,
        decoration: InputDecoration(
          hintText: 'description',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        maxLines: 3,
        style: TextStyle(
          color: Utils(context).color,
        ),
      ),
    );
  }
}
