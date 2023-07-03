import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

import '../consts/textstyle.dart';
import '../utils/screensize.dart';


class ImagePickerWidget extends StatefulWidget {
  ImagePickerWidget({
    super.key,
    this.selectImage,
    this.onCancelled,
    this.selectedImage,
    this.webimage,
    this.size,
  });

  VoidCallback? selectImage;
  VoidCallback? onCancelled;
  File? selectedImage;
  Uint8List? webimage;
  Size? size;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.selectImage,
      child: Stack(
        children: [
          Container(
            width: isPC(context) ? 50.w : 100.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(
                width: 0.2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: kIsWeb
                ? widget.webimage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_size_select_actual_outlined,
                            size: 10.w,
                            color: Colors.grey[700],
                          ),
                          Text(
                            "Select a photo",
                            style: kTextStyle(15, context),
                          ),
                        ],
                      )
                    : Image.memory(widget.webimage!)
                : widget.selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_size_select_actual_outlined,
                            size: 10.w,
                            color: Colors.grey[700],
                          ),
                          Text(
                            "Select a photo",
                            style: kTextStyle(15, context),
                          ),
                        ],
                      )
                    : Image.file(widget.selectedImage!),
          ),
          kIsWeb && widget.webimage != null
              ? IconButton(
                  onPressed: widget.onCancelled,
                  icon: Icon(
                    Icons.clear_rounded,
                  ),
                )
              : !kIsWeb && widget.selectedImage != null
                  ? IconButton(
                      onPressed: widget.onCancelled,
                      icon: Icon(
                        Icons.clear_rounded,
                      ),
                    )
                  : const SizedBox()
        ],
      ),
    );
  }
}
