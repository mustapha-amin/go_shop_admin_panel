import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/input_fields.dart';
import 'package:go_shop_admin_panel/widgets/select_image_widget.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../services/utils.dart';
import '../widgets/loading_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  custom.Category? category;
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  bool isLoading = false;

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } on PlatformException catch (e) {
      log(e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var categories = Provider.of<List<custom.Category>>(context);
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            drawer: SideMenu(),
            appBar: AppBar(
              title: Text("Add product"),
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey[600] as Color,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 20,
                                        top: 5,
                                      ),
                                      child: DropdownButton<custom.Category>(
                                        iconSize: 5.h,
                                        isExpanded: true,
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Category",
                                            style: GoogleFonts.lato(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        elevation: 0,
                                        dropdownColor: Colors.grey[300],
                                        value: category,
                                        items: categories
                                            .map((e) => DropdownMenuItem<
                                                    custom.Category>(
                                                  value: e,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      e.name!,
                                                      style: kTextStyle(
                                                          15, context),
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
                                ),
                                addVerticalSpacing(20),
                                InputFields(
                                    priceController: priceController,
                                    productNameController:
                                        productNameController,
                                    descriptionController:
                                        descriptionController,
                                    quantityController: quantityController),
                                addVerticalSpacing(20),
                                InkWell(
                                  onTap: selectImage,
                                  child: Stack(
                                    children: [
                                      Container(
                                          width: 100.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                              width: 0.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: selectedImage == null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .photo_size_select_actual_outlined,
                                                      size: size.width / 10,
                                                      color: Colors.grey[700],
                                                    ),
                                                    Text(
                                                      "Select a photo",
                                                      style: kTextStyle(
                                                          15, context),
                                                    ),
                                                  ],
                                                )
                                              : Image.file(selectedImage!)),
                                      selectedImage != null
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedImage = null;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.clear_rounded,
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpacing(10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  height: 9.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 2, 40),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      priceController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              productNameController.text.isNotEmpty &&
                              quantityController.text.isNotEmpty &&
                              selectedImage != null
                          ? {
                              setState(() {
                                isLoading = true;
                              }),
                              await Database().addProduct(
                                context,
                                Product(
                                  name: productNameController.text.trim(),
                                  imgPath: selectedImage!.path,
                                  price: double.parse(
                                      priceController.text.replaceAll(',', '')),
                                  category: category!.name,
                                  description: descriptionController.text,
                                ),
                              ),
                            }
                          : showSnackbar(context, "Fill the required details");
                    },
                    child: const Text("Upload product"),
                  ),
                ),
                addVerticalSpacing(10),
              ],
            ),
          );
  }
}
