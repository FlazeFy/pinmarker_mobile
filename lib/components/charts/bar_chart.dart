import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getBarChart(List<PieData> chartData, String title, String? extra) {
  return SfCartesianChart(
    title: ChartTitle(
      text: title,
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
    ),
    legend: const Legend(isVisible: false),
    primaryXAxis: const CategoryAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    primaryYAxis: const NumericAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    series: <ColumnSeries<PieData, String>>[
      ColumnSeries<PieData, String>(
        dataSource: chartData,
        xValueMapper: (PieData data, _) => data.xData,
        yValueMapper: (PieData data, _) => data.yData,
        dataLabelMapper: (PieData data, _) =>
            '${double.parse(data.yData.toStringAsFixed(2))}$extra',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        color: Colors.blue,
      ),
    ],
  );
}
