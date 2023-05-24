import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:image_picker/image_picker.dart';

import '../consts/textstyle.dart';
import '../services/utils.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
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
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: selectImage,
      child: Stack(
        children: [
          Container(
            width: Responsive.isMobile(context) ? size.width : size.width / 3,
            height: Responsive.isMobile(context)
                ? size.height / 3.4
                : size.height / 1.5,
            decoration: BoxDecoration(
              color:
                  Utils(context).isDark ? Colors.grey[800] : Colors.grey[300],
              border: Border.all(
                width: 0.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _selectedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_size_select_actual_outlined,
                        size: size.width / 10,
                        color: Utils(context).isDark
                            ? Colors.grey[500]
                            : Colors.grey[700],
                      ),
                      Text(
                        "Select a photo",
                        style: kTextStyle(15, context),
                      ),
                    ],
                  )
                : Image.file(
                    _selectedImage!,
                    filterQuality: FilterQuality.high,
                  ),
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
                    color: Utils(context).color,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
