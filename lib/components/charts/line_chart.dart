import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getLineChart(List<PieData> chartData, String title) {
  return SfCartesianChart(
    title: ChartTitle(
      text: title,
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
    ),
    legend: Legend(
      isVisible: true,
      padding: 8,
      backgroundColor: Colors.white,
      position: LegendPosition.bottom,
      orientation: LegendItemOrientation.horizontal,
      textStyle: const TextStyle(color: Colors.black),
      overflowMode: LegendItemOverflowMode.wrap,
      borderColor: Colors.black,
    ),
    primaryXAxis: CategoryAxis(
      title: AxisTitle(
        text: 'Categories',
        textStyle: const TextStyle(color: Colors.black),
      ),
    ),
    primaryYAxis: NumericAxis(
      title: AxisTitle(
        text: 'Values',
        textStyle: const TextStyle(color: Colors.black),
      ),
    ),
    series: <LineSeries<PieData, String>>[
      LineSeries<PieData, String>(
        dataSource: chartData,
        xValueMapper: (PieData data, _) => data.xData,
        yValueMapper: (PieData data, _) => data.yData,
        dataLabelMapper: (PieData data, _) => '${data.yData}',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        markerSettings: const MarkerSettings(
          isVisible: true,
          shape: DataMarkerType.circle,
        ),
      ),
    ],
  );
}
