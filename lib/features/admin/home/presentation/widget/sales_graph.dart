import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../view_model/sales_helper.dart';

/// @author : Jibin K John
/// @date   : 19/08/2024
/// @time   : 13:02:46

enum Filter { day, week, month, year }

class SalesGraph extends StatefulWidget {
  const SalesGraph({super.key});

  @override
  State<SalesGraph> createState() => _SalesGraphState();
}

class _SalesGraphState extends State<SalesGraph> {
  final List<ChartData> _dayChart = [];
  final List<ChartData> _weekChart = [];
  final List<ChartData> _monthChart = [];
  final List<ChartData> _yearChart = [];
  final ValueNotifier<Filter> _filter = ValueNotifier(Filter.day);

  @override
  void initState() {
    SalesHelper.initGraphData(
      dayChart: _dayChart,
      weekChart: _weekChart,
      monthChart: _monthChart,
      yearChart: _yearChart,
    );
    super.initState();
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _filter,
      builder: (ctx, filter, _) {
        return Column(
          children: [
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Filter.values.map((filterValue) {
                final isSelected = filter == filterValue;
                final filterText = filterValue.toString().split('.').last;
                return FilledButton(
                  onPressed: () => _filter.value = filterValue,
                  style: FilledButton.styleFrom(
                    foregroundColor:
                        isSelected ? null : Theme.of(context).primaryColor,
                    backgroundColor:
                        isSelected ? null : Colors.grey.withOpacity(.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0),
                  ),
                  child: Text(
                    "${filterText[0].toUpperCase()}${filterText.substring(1)}",
                    style: const TextStyle(fontSize: 12.0),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30.0),
            SfCartesianChart(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                majorGridLines: const MajorGridLines(color: Colors.transparent),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: "Products sold",
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                majorGridLines: const MajorGridLines(color: Colors.transparent),
                minorGridLines: const MinorGridLines(color: Colors.transparent),
              ),
              series: <CartesianSeries>[
                SplineAreaSeries<ChartData, String>(
                  dataSource: _getChart(filter),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  borderColor: Colors.blue,
                  borderWidth: 3.0,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    stops: const [.1, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  // Function to return corresponding graph data
  List<ChartData> _getChart(Filter filter) {
    switch (filter) {
      case Filter.year:
        return _yearChart;
      case Filter.month:
        return _monthChart;
      case Filter.week:
        return _weekChart;
      default:
        return _dayChart;
    }
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int? y;
}
