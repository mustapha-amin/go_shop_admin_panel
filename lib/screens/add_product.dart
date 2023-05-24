import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/widgets/category_dropdown.dart';
import 'package:go_shop_admin_panel/widgets/input_fields.dart';
import 'package:go_shop_admin_panel/widgets/select_image_widget.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';

import '../services/utils.dart';
import '../widgets/custom_textfield.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Responsive.isMobile(context)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFields(
                          priceController: priceController,
                          productNameController: productNameController,
                        ),
                        addVerticalSpacing(20),
                        const SelectImage(),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          size.width,
                          size.height / 15,
                        ),
                        backgroundColor: Color.fromARGB(255, 13, 2, 40),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Upload product"),
                    )
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFields(
                        priceController: priceController,
                        productNameController: productNameController,
                      ),
                      DescriptionField(
                        descriptionController: descriptionController,
                      ),
                      addVerticalSpacing(20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width / 4, size.height / 10),
                            backgroundColor: Color.fromARGB(255, 13, 2, 40)),
                        onPressed: () {},
                        child: Text(
                          "Add",
                          style: kTextStyle(20, context),
                        ),
                      )
                    ],
                  ),
                  SelectImage()
                ],
              ),
      ),
    );
  }
}
