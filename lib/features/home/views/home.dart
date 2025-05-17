import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:go_shop_admin_panel/features/home/widgets/dashboard_card.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        "Dashboard".style(fontSize: 20, isBold: true),
        DashboardSummaryCard(
          customers: 30000,
          income: 200000,
          growthPercentage: 80,
        ),
      ],
    );
  }
}
