import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/utils/extensions.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  ProductWidget({this.product, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Utils(context).isDark ? Colors.grey[800] : Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.product!.imgPath!),
                  filterQuality: FilterQuality.high,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Text(
            widget.product!.name!,
            style:
                GoogleFonts.lato(fontSize: 15.sp, color: Utils(context).color),
          ),
          Text(
            widget.product!.price!.toMoney,
            style:
                GoogleFonts.lato(fontSize: 18.sp, color: Utils(context).color),
          ),
        ],
      ),
    );
  }
}
