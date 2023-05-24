import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/textstyle.dart';
import '../global_products.dart';
import '../model/category.dart';
import '../services/utils.dart';

class CategoriesDropdown extends StatefulWidget {
  const CategoriesDropdown({super.key});

  @override
  State<CategoriesDropdown> createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  Category? _category;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 12,
      width: Responsive.isMobile(context) ? size.width : size.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[600] as Color,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Category>(
          hint: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Category",
              style: GoogleFonts.lato(
                color: Colors.grey,
              ),
            ),
          ),
          elevation: 0,
          dropdownColor:
              Utils(context).isDark ? Colors.grey[700] : Colors.grey[300],
          value: _category,
          items: GlobalProducts.categories
              .map((e) => DropdownMenuItem<Category>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        e.name!,
                        style: kTextStyle(15, context),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              _category = val;
            });
          },
        ),
      ),
    );
  }
}
