import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:sizer/sizer.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final Widget destination;
  final IconData icon;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.destination,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: kTextStyle(15, context),
      ),
      leading: Icon(
        icon,
        size: 15,
      ),
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return destination;
        }));
      },
    );
  }
}
