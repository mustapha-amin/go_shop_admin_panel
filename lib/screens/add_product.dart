import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/input_fields.dart';
import 'package:go_shop_admin_panel/widgets/select_image_widget.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../services/utils.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  custom.Category? category;
  File? selectedImage;
  Database database = Database();
  final _formKey = GlobalKey<FormState>();

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      Uint8List webImage = Uint8List(8);

      if (!kIsWeb) {
        if (image != null) {
          setState(() {
            selectedImage = File(image.path);
          });
        }
      } else {
        if (image != null) {
          setState(() async {
            webImage = await image.readAsBytes();
          });
        }
      }
    } on PlatformException catch (e) {
      log(e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var categories = Provider.of<List<custom.Category>>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
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
                          Container(
                            height: 10.h,
                            width: Responsive.isMobile(context) ? 100.w : 20.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey[600] as Color,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<custom.Category>(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Category",
                                    style: GoogleFonts.lato(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                elevation: 0,
                                dropdownColor: Utils(context).isDark
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
                                value: category,
                                items: categories
                                    .map((e) =>
                                        DropdownMenuItem<custom.Category>(
                                          value: e,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              e.name!,
                                              style: kTextStyle(15, context),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    category = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          addVerticalSpacing(20),
                          InputFields(
                            priceController: priceController,
                            productNameController: productNameController,
                            descriptionController: descriptionController,
                          ),
                          addVerticalSpacing(20),
                          SelectImage(
                            selectedImage: selectedImage,
                            onSelected: selectImage,
                            onCancelled: () => setState(() {
                              selectedImage = null;
                            }),
                          ),
                        ],
                      ),
                      addVerticalSpacing(10),
                      SizedBox(
                        width: 100.w,
                        height: 7.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 13, 2, 40),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            priceController.text.isNotEmpty &&
                                    descriptionController.text.isNotEmpty &&
                                    productNameController.text.isNotEmpty &&
                                    selectedImage != null
                                ? {
                                    await Database.addProduct(
                                      context,
                                      Product(
                                        name: productNameController.text.trim(),
                                        imgPath: selectedImage!.path,
                                        price: double.parse(priceController.text
                                            .replaceAll(',', '')),
                                        category: category!.name,
                                      ),
                                    ),
                                    Navigator.pop(context)
                                  }
                                : showSnackbar(
                                    context, "Fill the required details");
                          },
                          child: const Text("Upload product"),
                        ),
                      ),
                      addVerticalSpacing(10),
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
                          descriptionController: descriptionController,
                          selectedCategory: category,
                        ),
                        addVerticalSpacing(20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width / 4, size.height / 10),
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 2, 40)),
                          onPressed: () {},
                          child: Text(
                            "Add",
                            style: kTextStyle(20, context),
                          ),
                        )
                      ],
                    ),
                    SelectImage(
                      selectedImage: selectedImage,
                      onSelected: selectImage,
                      onCancelled: () => setState(() {
                        selectedImage = null;
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
