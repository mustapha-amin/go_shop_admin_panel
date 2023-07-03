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
import '../utils/screensize.dart';
import '../widgets/image_picker.dart';
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
  Uint8List? webImage;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> addProductKey = GlobalKey();

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (!kIsWeb) {
        if (image != null) {
          setState(() {
            selectedImage = File(image.path);
          });
        }
      } else {
        if (image != null) {
          var img = await image.readAsBytes();
          setState(() {
            webImage = img;
            selectedImage = File('a');
          });
        }
      }
    } on PlatformException catch (e) {
      log(e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && addProductKey.currentState!.isDrawerOpen
          ? addProductKey.currentState!.openEndDrawer()
          : null;
    });
    Size size = MediaQuery.of(context).size;
    var categories = Provider.of<List<custom.Category>>(context);
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            key: addProductKey,
            drawer: const SideMenu(),
            resizeToAvoidBottomInset: false,
            appBar: isPC(context)
                ? null
                : AppBar(
                    title: Text("Add product"),
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            });
                      },
                    ),
                  ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isPC(context) ? const SideMenu() : const SizedBox(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 9.h,
                                          width: isPC(context) ? 40.w : 100.w,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child:
                                                DropdownButton<custom.Category>(
                                              padding: EdgeInsets.all(4),
                                              elevation: 3,
                                              value: category,
                                              isExpanded: true,
                                              onChanged: (val) {
                                                setState(() {
                                                  category = val;
                                                });
                                              },
                                              hint: const Text(
                                                  'Select a category'),
                                              items: categories.map<
                                                      DropdownMenuItem<
                                                          custom.Category>>(
                                                  (custom.Category value) {
                                                return DropdownMenuItem<
                                                    custom.Category>(
                                                  value: value,
                                                  child: Text(value.name!),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        addVerticalSpacing(20),
                                        SizedBox(
                                          width: isPC(context) ? 40.w : 100.w,
                                          child: InputFields(
                                            priceController: priceController,
                                            productNameController:
                                                productNameController,
                                            descriptionController:
                                                descriptionController,
                                            quantityController:
                                                quantityController,
                                          ),
                                        ),
                                        addVerticalSpacing(20),
                                        !isPC(context)
                                            ? kIsWeb
                                                ? ImagePickerWidget(
                                                    webimage: webImage,
                                                    selectedImage: null,
                                                    onCancelled: () {
                                                      setState(() {
                                                        webImage = null;
                                                      });
                                                    },
                                                    size: isPC(context)
                                                        ? Size(45.w, 40.h)
                                                        : Size(100.w, 40.w),
                                                    selectImage: selectImage,
                                                  )
                                                : ImagePickerWidget(
                                                    selectedImage:
                                                        selectedImage,
                                                    webimage: null,
                                                    onCancelled: () {
                                                      setState(() {
                                                        selectedImage = null;
                                                      });
                                                    },
                                                    size: isPC(context)
                                                        ? Size(45.w, 45.h)
                                                        : Size(100.w, 45.w),
                                                    selectImage: selectImage,
                                                  )
                                            : const SizedBox()
                                      ],
                                    ),
                                    addVerticalSpacing(10),
                                  ],
                                ),
                              ),
                            ),
                            !isPC(context)
                                ? SizedBox(
                                    width: 100.w,
                                    height: 9.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 13, 2, 40),
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () async {
                                        priceController.text.isNotEmpty &&
                                                descriptionController
                                                    .text.isNotEmpty &&
                                                productNameController
                                                    .text.isNotEmpty &&
                                                quantityController
                                                    .text.isNotEmpty &&
                                                selectedImage != null
                                            ? {
                                                setState(() {
                                                  isLoading = true;
                                                }),
                                                await Database().addProduct(
                                                  context,
                                                  Product(
                                                    name: productNameController
                                                        .text
                                                        .trim(),
                                                    imgPath:
                                                        selectedImage!.path,
                                                    price: double.parse(
                                                        priceController.text
                                                            .replaceAll(
                                                                ',', '')),
                                                    category: category!.name,
                                                    description:
                                                        descriptionController
                                                            .text,
                                                  ),
                                                ),
                                              }
                                            : showSnackbar(context,
                                                "Fill the required details");
                                      },
                                      child: const Text("Upload product"),
                                    ),
                                  )
                                : const SizedBox(),
                            addVerticalSpacing(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                isPC(context)
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          kIsWeb
                              ? ImagePickerWidget(
                                  webimage: webImage,
                                  selectedImage: null,
                                  onCancelled: () {
                                    setState(() {
                                      webImage = null;
                                    });
                                  },
                                  size: isPC(context)
                                      ? Size(45.w, 40.h)
                                      : Size(100.w, 40.w),
                                  selectImage: selectImage,
                                )
                              : ImagePickerWidget(
                                  selectedImage: selectedImage,
                                  webimage: null,
                                  onCancelled: () {
                                    setState(() {
                                      selectedImage = null;
                                    });
                                  },
                                  size: isPC(context)
                                      ? Size(45.w, 45.h)
                                      : Size(100.w, 45.w),
                                  selectImage: selectImage,
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 20.w,
                              height: 6.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 13, 2, 40),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  priceController.text.isNotEmpty &&
                                          descriptionController
                                              .text.isNotEmpty &&
                                          productNameController
                                              .text.isNotEmpty &&
                                          quantityController.text.isNotEmpty &&
                                          selectedImage != null
                                      ? {
                                          setState(() {
                                            isLoading = true;
                                          }),
                                          await Database().addProduct(
                                            context,
                                            Product(
                                              name: productNameController.text
                                                  .trim(),
                                              imgPath: selectedImage!.path,
                                              price: double.parse(
                                                  priceController.text
                                                      .replaceAll(',', '')),
                                              category: category!.name,
                                              description:
                                                  descriptionController.text,
                                            ),
                                          ),
                                        }
                                      : showSnackbar(
                                          context, "Fill the required details");
                                },
                                child: const Text("Upload product"),
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          );
  }
}
