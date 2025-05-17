import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_shop_admin_panel/consts/assets.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

final dashboardIndexProvider = StateProvider<int>((ref) => 0);

class CustomTile extends ConsumerWidget {
  final String title;
  final IconData iconData;
  final int index;

  const CustomTile({
    required this.title,
    required this.iconData,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListTile(
        minVerticalPadding: 0,
        minTileHeight: 45,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        horizontalTitleGap: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tileColor:
            index == ref.watch(dashboardIndexProvider)
                ? Theme.of(context).primaryColor
                : Colors.transparent,
        leading: Icon(
          iconData,
          size: 15,
          color:
              index == ref.watch(dashboardIndexProvider)
                  ? Colors.white
                  : Colors.black,
        ),
        onTap: () {
          ref.read(dashboardIndexProvider.notifier).state = index;
        },
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color:
                index == ref.watch(dashboardIndexProvider)
                    ? Colors.white
                    : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DashboardDrawer extends ConsumerWidget {
  final Color color;
  const DashboardDrawer({this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: 250,
      backgroundColor: color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              ImagePaths.logo,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          CustomTile(title: 'Home', iconData: Iconsax.home_copy, index: 0),
          CustomTile(
            title: 'Inventory',
            iconData: Iconsax.shopping_cart_copy,
            index: 1,
          ),
          CustomTile(
            title: 'Add products',
            iconData: Iconsax.shop_add_copy,
            index: 2,
          ),
          CustomTile(
            title: 'Customers',
            iconData: Iconsax.people_copy,
            index: 3,
          ),
          CustomTile(title: 'Orders', iconData: Iconsax.receipt_copy, index: 4),
          CustomTile(
            title: 'Income',
            iconData: Iconsax.dollar_circle_copy,
            index: 5,
          ),
        ],
      ),
    );
  }
}
