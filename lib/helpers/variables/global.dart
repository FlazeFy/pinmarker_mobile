import 'package:camera/camera.dart';

int selectedIndexBottomBar = 0;
int selectedIndexLeftBar = 0;

FlashMode flashMode = FlashMode.off;

int checkIntervalTimeHigh = 5; // in second
int checkIntervalTimeMid = 7; // in second
int checkIntervalTimeLow = 10; // in second

bool isShownOffLocationPop = false;

class PieData {
  PieData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

bool isOffline = false;
int statsFetchRestTime = 180; // in second
int allPinFetchRestTime = 60; // in second
int nearestPinFetchRestTime = 60; // in second
double nearestPinFetchRestDistance = 10; // In meter
double generalFetchRestDistance = 10; // In meter
