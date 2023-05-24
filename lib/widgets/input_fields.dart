import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';

import '../services/utils.dart';
import 'category_dropdown.dart';
import 'custom_textfield.dart';

class InputFields extends StatefulWidget {
  TextEditingController? priceController, productNameController;

  InputFields({
    this.priceController,
    this.productNameController,
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
          productNameController: widget.priceController!,
          valueKey: 'product',
        ),
        addVerticalSpacing(10),
        const CategoriesDropdown(),
        addVerticalSpacing(10),
        CustomTextField(
          hint: 'Price',
          productNameController: widget.productNameController!,
          valueKey: 'price',
          isPrice: true,
        ),
        addVerticalSpacing(10),
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
      width: size.width / 4,
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
