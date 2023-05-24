import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final IconData icon;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: kTextStyle(17, context),
      ),
      leading: Icon(
        icon,
        size: 20,
      ),
      onTap: press,
    );
  }
}
