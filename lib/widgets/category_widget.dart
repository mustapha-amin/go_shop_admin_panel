
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/screens/products.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/category.dart';

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
        padding: const EdgeInsets.all(5),
        height: size.height / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[400],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(category.imgPath!),
                    filterQuality: FilterQuality.high,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Text(
              category.name!,
              style:
                  GoogleFonts.lato(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
