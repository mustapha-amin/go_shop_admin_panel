import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/utils/screensize.dart';
import 'package:sizer/sizer.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isPCorTablet(context) ? 50.h : 70.h,
      width: !isPCorTablet(context) ? 100.w : 50.w,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                "Months",
                style: kTextStyle(
                  15,
                  context,
                ),
              ),
              sideTitles: const SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 4),
              left: const BorderSide(color: Colors.transparent),
              right: const BorderSide(color: Colors.transparent),
              top: const BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: Colors.blue,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: const [
                FlSpot(1, 200000),
                FlSpot(2, 150000),
                FlSpot(3, 150000),
                FlSpot(4, 600000),
                FlSpot(5, 300000),
                FlSpot(7, 675000),
                FlSpot(7, 150000),
                FlSpot(8, 340000),
                FlSpot(9, 500000),
                FlSpot(10, 350000),
                FlSpot(11, 280000),
                FlSpot(12, 555000),
              ],
            )
          ],
          minX: 1,
          maxX: 12,
          maxY: 700000,
          minY: 0,
        ),
        duration: const Duration(milliseconds: 150), // Optional
        curve: Curves.linear, // Optional
      ),
    );
  }
}
