import 'package:flutter/cupertino.dart';

extension DeviceRatio on BuildContext {
  //get widget width by percentage
  double getWidthInPercentage(int percentage) {
    return MediaQuery.of(this).size.width * (percentage / 100);
  }

  //get widget height by percentage
  double getHeightInPercentage(int percentage) {
    return MediaQuery.of(this).size.height * (percentage / 100);
  }
}