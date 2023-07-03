import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/screens/products.dart';
import 'package:go_shop_admin_panel/widgets/shimmer_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../consts/textstyle.dart';
import '../model/category.dart';
import '../utils/screensize.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Products(
              categoryId: category.name,
            );
          }));
        },
        child: Container(
          width: isPCorTablet(context) ? 40.w : 50.w,
          height: isPCorTablet(context) ? 40.w : 50.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey.withOpacity(0.1),
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          child: Stack(
            children: [
              Image.network(category.imgPath!, height: 26.w, scale: 1.5,
                  frameBuilder: (context, child, frame, _) {
                if (frame == null) {
                  return ShimmerWidget(
                    height: size.height / 7,
                    width: size.width / 3,
                  );
                }
                return child;
              }),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name!,
                      style: kTextStyle(20, context, isBold: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
