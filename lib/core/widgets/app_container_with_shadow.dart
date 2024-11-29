import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_manager.dart';

class AppContainerWithShadow extends StatelessWidget {
  const AppContainerWithShadow({
    super.key, this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              offset: Offset(2.sp, 0),
              spreadRadius: 2.sp,
              blurRadius: 10.sp,
            )
          ]),
      child: child,
    );
  }
}
