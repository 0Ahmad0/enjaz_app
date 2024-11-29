import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';

class StyleManager {
  ///Light Style
  static TextStyle font10Light({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
      );
  static TextStyle font12Light({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      );

  ///Regular Style

  static TextStyle font10Regular({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font12Regular({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font14Regular({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font16Regular({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  /// Medium Style
  static TextStyle font10Medium({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.w500);

  static TextStyle font24Medium({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.w500);

  static TextStyle font12Medium({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.w400);

  static TextStyle font14Medium({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.w500);

  static TextStyle font18Medium({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  /// Semi-Bold Style
  static TextStyle font12SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle font14SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle font16SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle font18SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle font20SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle font30SemiBold({Color color = ColorManager.blackColor}) =>
      TextStyle(
        color: color,
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      );


  /// Bold Style
  static TextStyle font10Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.w700);

  static TextStyle font14Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.w700);

  static TextStyle font20Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 20.sp, fontWeight: FontWeight.w700);

  static TextStyle font24Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.w700);

  static TextStyle font30Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 30.sp, fontWeight: FontWeight.w700);
  static TextStyle font40Bold({Color color = ColorManager.blackColor}) =>
      TextStyle(color: color, fontSize: 40.sp, fontWeight: FontWeight.w700);
}
