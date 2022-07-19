// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';

abstract class AppFontStyle {
  static TextStyle textFiledHintStyle = const TextStyle(
      color: AppStyle.mediumGrey,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.3);

  /// alsurrah

  //blue start

  static TextStyle blueLabel = const TextStyle(
      color: AppStyle.darkOrange,
      fontSize: 14,
      // fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle biggerBlueLabel = const TextStyle(
      color: AppStyle.darkOrange,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3);
  //blue end

  //grey start
  static TextStyle darkGreyLabel = const TextStyle(
      color: AppStyle.darkGrey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3);

  static TextStyle hugDarkGreyLabel = const TextStyle(
      color: AppStyle.darkGrey,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle descFont =
      const TextStyle(color: AppStyle.mediumGrey, fontSize: 14, height: 1.3);

  // grey end

// white start

  static TextStyle whiteLabel = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle whiteDesc = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      // fontWeight: FontWeight.w600,
      height: 1.3);

// white end

}
