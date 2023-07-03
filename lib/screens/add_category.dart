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
import 'package:go_shop_admin_panel/widgets/input_fields.dart';
import 'package:go_shop_admin_panel/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../consts/textstyle.dart';
import '../services/utils.dart';
import '../utils/screensize.dart';
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
  Uint8List? webImage;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> addCategoryKey = GlobalKey();

  Future<void> selectImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (!kIsWeb) {
        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
          });
        }
      } else {
        if (image != null) {
          var img = await image.readAsBytes();
          setState(() {
            webImage = img;
            _selectedImage = File('a');
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
      isPCorTablet(context) && addCategoryKey.currentState!.isDrawerOpen
          ? addCategoryKey.currentState!.openEndDrawer()
          : null;
    });
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            key: addCategoryKey,
            drawer: const SideMenu(),
            resizeToAvoidBottomInset: false,
            appBar: isPC(context)
                ? null
                : AppBar(
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
            body: Row(
              children: [
                isPC(context) ? SideMenu() : SizedBox(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Category",
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
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
                                    child: _selectedImage == null ||
                                            webImage == null
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
                                        : kIsWeb
                                            ? Image.memory(webImage!)
                                            : Image.file(_selectedImage!),
                                  ),
                                  _selectedImage != null || webImage != null
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              kIsWeb
                                                  ? _selectedImage = null
                                                  : webImage = null;
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
                        isPCorTablet(context)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 200,
                                      height: 7.h,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 13, 2, 40),
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
                                                        name: controller.text
                                                            .trim(),
                                                        imgPath: _selectedImage!
                                                            .path),
                                                  ),
                                                }
                                              : showSnackbar(context,
                                                  "Fill the required details");
                                        },
                                        child: const Text("Add category"),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        !isPCorTablet(context)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100.w,
                                  height: 8.h,
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
                                                    name:
                                                        controller.text.trim(),
                                                    imgPath:
                                                        _selectedImage!.path),
                                              ),
                                            }
                                          : showSnackbar(context,
                                              "Fill the required details");
                                    },
                                    child: const Text("Add category"),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
