int selectedIndex = 0;

double distanceDiffToTrack = 10; // In meter
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
int statsFetchRestTime = 180;
int allPinFetchRestTime = 60;
