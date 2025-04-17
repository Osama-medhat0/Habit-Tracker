import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/date/date_time.dart';

class MonthlyProgress extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlyProgress({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets, //Records
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 28,
        colorsets: {
          1: Colors.purple.shade100,
          2: Colors.purple.shade200,
          3: Colors.purple.shade300,
          4: Colors.purple.shade400,
          5: Colors.purple.shade500,
          6: Colors.purple.shade600,
          7: Colors.purple.shade700,
          8: Colors.purple.shade800,
          9: Colors.purple.shade900,
          10: const Color(0xFF4B0082),
        },
      ),
    );
  }
}
