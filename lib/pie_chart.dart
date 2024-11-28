import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingPieChart extends StatelessWidget {
  final Map<String, double> spending;

  SpendingPieChart({required this.spending});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: spending.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,
              title: '${entry.key}\n${entry.value}',
              color: Colors.primaries[spending.keys.toList().indexOf(entry.key) % Colors.primaries.length],
            );
          }).toList(),
        ),
      ),
    );
  }
}
