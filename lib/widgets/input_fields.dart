import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:go_shop_admin_panel/utils/extensions.dart';
import '../consts/textstyle.dart';
import '../services/utils.dart';
import 'custom_textfield.dart';

class InputFields extends StatefulWidget {
  TextEditingController? priceController,
      productNameController,
      descriptionController,
      quantityController;

  InputFields({
    this.priceController,
    this.productNameController,
    this.descriptionController,
    this.quantityController,
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
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Product",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          controller: widget.productNameController!,
        ),
        addVerticalSpacing(10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 3),
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixText: "NGN",
                  ),
                  controller: widget.priceController!,
                  onChanged: (_) {
                    widget.priceController!.text.isNotEmpty
                        ? setState(() {
                            widget.priceController!.text = double.parse(widget
                                    .priceController!.text
                                    .replaceAll(',', ''))
                                .toMoney;
                            widget.priceController!.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: widget.priceController!.text.length),
                            );
                          })
                        : null;
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: widget.quantityController!,
                ),
              ),
            ),
          ],
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
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      key: const ValueKey('description'),
      controller: widget.descriptionController,
      decoration: InputDecoration(
        hintText: 'description',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: 3,
    );
  }
}
