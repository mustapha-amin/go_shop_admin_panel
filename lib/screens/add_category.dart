import 'dart:developer';
import 'dart:io';
import 'package:go_shop_admin_panel/consts/enums.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/custom_textfield.dart';
import 'package:go_shop_admin_panel/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../consts/textstyle.dart';
import '../services/utils.dart';
import '../widgets/select_image_widget.dart';
import '../widgets/side_menu.dart';
import '../widgets/spacings.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController controller = TextEditingController();
  File? _selectedImage;
  bool isLoading = false;

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
          });
        }
      
    } on PlatformException catch (e) {
      log(e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            drawer: SideMenu(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
              title: const Text("Add a category"),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        hint: 'Category name',
                        controller: controller,
                        valueKey: 'category',
                      ),
                      addVerticalSpacing(20),
                      InkWell(
                        onTap: selectImage,
                        child: Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _selectedImage == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .photo_size_select_actual_outlined,
                                          size: 10.w,
                                          color: Colors.grey[700],
                                        ),
                                        Text(
                                          "Select a photo",
                                          style: kTextStyle(15, context),
                                        ),
                                      ],
                                    )
                                  : Image.file(_selectedImage!),
                            ),
                            _selectedImage != null
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedImage = null;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100.w,
                      height: 7.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 13, 2, 40),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          controller.text.isNotEmpty &&
                                  _selectedImage != null
                              ? {
                                  setState(() {
                                    isLoading = true;
                                  }),
                                  await Database().addCategory(
                                    context,
                                    custom.Category(
                                        name: controller.text.trim(),
                                        imgPath: _selectedImage!.path),
                                  ),
                                }
                              : showSnackbar(
                                  context, "Fill the required details");
                        },
                        child: const Text("Add category"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
