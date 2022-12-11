import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late BuildContext context;
  static late double height;
  static late double width;
  static init(BuildContext con) {
    context = con;
    mediaQueryData = MediaQuery.of(context);
    height = mediaQueryData.size.height;
    width = mediaQueryData.size.width;
  }
}

double getHeight(double inputHeight) {
  // 812 is the layout height that designer use
  return (inputHeight / 640.0) * SizeConfig.height;
}

// Get the proportionate height as per screen size
double getWidth(double inputWidth) {
  // 375 is the layout width that designer use
  return (inputWidth / 360.0) * SizeConfig.width;
}

SizedBox getSizedBox({double? h, double? w}) {
  return SizedBox(
    height: h == null ? null : getHeight(h),
    width: w == null ? null : getWidth(w),
  );
}

