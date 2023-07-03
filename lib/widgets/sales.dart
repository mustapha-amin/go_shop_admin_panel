import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';

import '../consts/textstyle.dart';
import '../utils/consts.dart';

class SalesWidget extends StatelessWidget {
  const SalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total income:",
          style: kTextStyle(12, context),
        ),
        Text(
          "$nairaSymbol 7000,000",
          style: kTextStyle(15, context),
        ),
        addVerticalSpacing(20),
        Text(
          "Customers:",
          style: kTextStyle(12, context),
        ),
        Text(
          "240",
          style: kTextStyle(15, context),
        ),
      ],
    );
  }
}
