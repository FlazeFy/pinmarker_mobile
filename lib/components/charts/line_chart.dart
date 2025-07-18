import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getLineChart(List<PieData> chartData, String? title, String? extra) {
  return SfCartesianChart(
    title: title != null
        ? ChartTitle(
            text: title,
            textStyle: TextStyle(color: primaryColor, fontSize: textLG))
        : ChartTitle(),
    legend: Legend(isVisible: false),
    primaryXAxis: CategoryAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    primaryYAxis: NumericAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    series: <LineSeries<PieData, String>>[
      LineSeries<PieData, String>(
        dataSource: chartData,
        xValueMapper: (PieData data, _) => data.xData,
        yValueMapper: (PieData data, _) => data.yData,
        dataLabelMapper: (PieData data, _) =>
            '${double.parse(data.yData.toStringAsFixed(2))}$extra',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: textSM,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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
