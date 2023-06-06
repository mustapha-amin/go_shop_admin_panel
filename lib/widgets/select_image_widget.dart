import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/responsive.dart';

import '../consts/textstyle.dart';
import '../services/utils.dart';

class SelectImage extends StatefulWidget {
  File? selectedImage;
  VoidCallback? onSelected;
  VoidCallback? onCancelled;
  SelectImage({this.selectedImage, this.onSelected, this.onCancelled, super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onSelected,
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
            child: widget.selectedImage == null
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
                    widget.selectedImage!,
                    filterQuality: FilterQuality.high,
                  ),
          ),
          widget.selectedImage != null
              ? IconButton(
                  onPressed: widget.onCancelled,
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
