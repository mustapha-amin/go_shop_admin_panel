import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:go_shop_admin_panel/features/home/widgets/dashboard_card.dart';
import 'package:go_shop_admin_panel/features/orders/controller/orders_controller.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(orderStatsProvider);

    return Column(
      children: [
        "Dashboard".style(fontSize: 20, isBold: true),
        statsAsync.when(
          data: (stats) => DashboardSummaryCard(
            customers: stats.uniqueCustomers,
            income: stats.totalIncome,
            growthPercentage: 30
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('Error loading stats: $error')),
        ),
      ],
    );
  }
}
