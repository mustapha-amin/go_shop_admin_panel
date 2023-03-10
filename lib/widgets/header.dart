import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:go_shop_admin_panel/widgets/search_bar.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height / 4.5,
      ),
      child: Responsive.isMobile(context)
          ? Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<MenuContoller>().controlDashboardMenu();
                      },
                      icon: Icon(Icons.menu),
                    ),
                    Text(
                      "DashBoard",
                      style: kTextStyle(20, context),
                    )
                  ],
                ),
                const SearchBar()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Dashboard",
                    style: kTextStyle(20, context),
                  ),
                ),
                addHorizontalSpacing(size.width * .3),
                SearchBar(),
              ],
            ),
    );
  }
}
