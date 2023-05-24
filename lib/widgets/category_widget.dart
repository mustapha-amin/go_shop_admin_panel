import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/category.dart';
import '../services/utils.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      height: size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Utils(context).isDark ? Colors.grey[800] : Colors.grey[400],
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
                  image: AssetImage(category.imgPath!),
                  filterQuality: FilterQuality.high,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Text(
            category.name!,
            style: GoogleFonts.lato(fontSize: 15, color: Utils(context).color),
          ),
        ],
      ),
    );
  }
}
