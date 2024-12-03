import 'dart:ui';

import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.r),
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
    return TextField(
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
        border: _borderTextFiled(color: ColorManager.grayColor),
        enabledBorder: _borderTextFiled(color: ColorManager.hintTextColor),
        focusedBorder: _borderTextFiled(color: Colors.transparent),
        filled: true,
        fillColor: ColorManager.grayColor,
      ),
    );
  }
}
