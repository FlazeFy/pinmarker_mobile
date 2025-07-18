import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getPieChart(List<PieData> chartData, String? title) {
  return SfCircularChart(
      title: title != null
          ? ChartTitle(
              text: title,
              textStyle: TextStyle(color: primaryColor, fontSize: textLG))
          : ChartTitle(),
      legend: Legend(
          isVisible: true,
          padding: spaceLG,
          backgroundColor: whiteColor,
          position: LegendPosition.bottom,
          orientation: LegendItemOrientation.horizontal,
          textStyle: const TextStyle(color: primaryColor),
          overflowMode: LegendItemOverflowMode.wrap,
          borderColor: primaryColor),
      series: <CircularSeries>[
        PieSeries<PieData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: chartData,
            xValueMapper: (PieData data, _) => data.xData,
            yValueMapper: (PieData data, _) => data.yData,
            dataLabelMapper: (PieData data, _) =>
                '${data.xData}: ${data.yData}',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontSize: textSM,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              connectorLineSettings: const ConnectorLineSettings(
                type: ConnectorType.curve,
                length: '10%',
              ),
            )),
      ]);
}
