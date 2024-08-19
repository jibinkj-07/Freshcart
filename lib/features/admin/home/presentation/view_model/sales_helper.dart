import 'dart:math' as math;

import '../widget/sales_graph.dart';

sealed class SalesHelper {
  static void initGraphData({
    required List<ChartData> dayChart,
    required List<ChartData> weekChart,
    required List<ChartData> monthChart,
    required List<ChartData> yearChart,
  }) {
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<String> weeks = ["Week 1", "Week 2", "Week 3", "Week 4"];
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    final currentTime = DateTime.now();
    final monthCount = currentTime.month;
    final weekday = currentTime.weekday;

    /// For day data
    for (int i = 0; i < currentTime.hour; i++) {
      dayChart.add(
        ChartData(
          "${i}h",
          _generateRandomNumber(10, 150),
        ),
      );
    }

    /// For week data
    for (final day in days) {
      weekChart.add(
        ChartData(
          day,
          days.indexOf(day) + 1 > weekday
              ? null
              : _generateRandomNumber(200, 600),
        ),
      );
    }

    /// For month data
    for (final week in weeks) {
      monthChart.add(
        ChartData(week, _generateRandomNumber(700, 2000)),
      );
    }

    /// For year data
    for (final month in months) {
      yearChart.add(
        ChartData(
          month,
          months.indexOf(month) + 1 > monthCount
              ? null
              : _generateRandomNumber(2500, 99999),
        ),
      );
    }
  }

  static _generateRandomNumber(int min, int max) =>
      min + math.Random().nextInt(max - min + 1);
}
