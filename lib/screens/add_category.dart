import 'dart:developer';
import 'dart:io';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../responsive.dart';
import '../widgets/select_image_widget.dart';
import '../widgets/spacings.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController controller = TextEditingController();
  File? _selectedImage;

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      Uint8List webImage = Uint8List(8);

      if (!kIsWeb) {
        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add a category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hint: 'Category name',
                  controller: controller,
                  valueKey: 'category',
                ),
                addVerticalSpacing(20),
                SelectImage(
                  selectedImage: _selectedImage,
                  onSelected: selectImage,
                  onCancelled: () => setState(() {
                    _selectedImage = null;
                  }),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Responsive.isMobile(context) ? 100.w : 40.w,
                height: 7.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 2, 40),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await Database.addCategory(
                      custom.Category(
                          name: controller.text, imgPath: _selectedImage!.path),
                    );
                    Navigator.pop(context);
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
