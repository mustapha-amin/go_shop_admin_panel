import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../consts/textstyle.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
          width: 20.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Colors.red,
                    value: 19,
                    radius: 25,
                    title: "19%",
                    titleStyle: kTextStyle(13, context, isBold: true),
                  ),
                  PieChartSectionData(
                      color: Colors.blue,
                      value: 21,
                      radius: 28,
                      title: "25%",
                      titleStyle: kTextStyle(13, context, isBold: true)),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 40,
                    title: "40%",
                    titleStyle: kTextStyle(13, context, isBold: true),
                    radius: 31,
                  ),
                  PieChartSectionData(
                    color: Colors.yellow,
                    value: 20,
                    title: "20%",
                    radius: 34,
                    titleStyle: kTextStyle(13, context, isBold: true),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListTile(
          leading: Container(
            color: Colors.red,
            width: 12,
            height: 12,
          ),
          title: Text("Shoes"),
        ),
        ListTile(
          leading: Container(
            color: Colors.blue,
            width: 12,
            height: 12,
          ),
          title: Text("Smartphones"),
        ),
        ListTile(
          leading: Container(
            color: Colors.green,
            width: 12,
            height: 12,
          ),
          title: Text("Home appliances"),
        ),
        ListTile(
          leading: Container(
            color: Colors.yellow,
            width: 12,
            height: 12,
          ),
          title: Text("Laptops"),
        ),
      ],
    );
  }
}
