import 'dart:ui';

import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color));

class AppSearchTextFiled extends StatelessWidget {
  const AppSearchTextFiled({
    super.key,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
     this.hintText = StringManager.searchText
  });
  final String hintText;
  final VoidCallback? onPressed;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: ColorManager.shadowColor,
            spreadRadius: 2.sp,
            blurRadius: 10.sp,
            offset: Offset(2.sp, 0))
      ]),
      child: TextField(

        onSubmitted: onSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w
          ),
          hintText: hintText,
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressed,
          ),
          border: _borderTextFiled(),
          enabledBorder: _borderTextFiled(color: Colors.transparent),
          focusedBorder: _borderTextFiled(color: Colors.transparent),
          filled: true,
          fillColor: ColorManager.grayColor,
        ),
      ),
    );
  }
}
