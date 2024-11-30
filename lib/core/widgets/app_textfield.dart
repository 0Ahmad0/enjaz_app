import '/core/utils/assets_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/color_manager.dart';
import '../utils/string_manager.dart';

var _borderTextFiled =
    ({Color color = ColorManager.primaryColor}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: color,
          width: 1.sp
        ));

class AppTextField extends StatefulWidget {
  AppTextField(
      {Key? key,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.iconData,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon = false,
      this.validator,
      this.onChanged,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.isMultiLine = false,
      this.maxLine = 1,
      this.minLine = 1,
      this.hintColor = ColorManager.hintTextColor,
      this.textColor = ColorManager.blackColor,
      this.filteringTextFormatterList,
      this.iconDataImage})
      : super(key: key);

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? iconData;
  final String? iconDataImage;
  final String? hintText;
  final Color? hintColor;
  final Color? textColor;
  final bool suffixIcon;
  final bool autofocus;
  final bool readOnly;
  bool obscureText;
  bool isMultiLine;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxLine;
  final int? minLine;
  final List<FilteringTextInputFormatter>? filteringTextFormatterList;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  void showPassword() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.filteringTextFormatterList,
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      validator: widget.validator ??
          (String? val) {
            if (val!.trim().isEmpty) return StringManager.requiredField;
            return null;
          },
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      cursorColor: ColorManager.primaryColor,
      decoration: InputDecoration(
          focusedBorder: _borderTextFiled(),
          border: _borderTextFiled(color: Colors.transparent),
          enabledBorder: _borderTextFiled(color: Colors.transparent),
          errorBorder: _borderTextFiled(color: ColorManager.errorColor),
          iconColor: ColorManager.grayColor,
          filled: true,
          fillColor: ColorManager.grayColor,
          errorMaxLines: 2,
          suffixIcon: widget.suffixIcon
              ? IconButton(
              onPressed: () {
                showPassword();
              },
              icon: Icon(
                !widget.obscureText
                    ? Icons.remove_red_eye
                    : Icons.visibility_off_sharp,
                color: ColorManager.hintTextColor,
              )):null,
          prefixIcon: widget.iconData != null
              ? Padding(
                padding: EdgeInsets.all(12.sp),
                child: SvgPicture.asset(
                    widget.iconData!,
                    width: 20.sp,
                    height: 20.sp,
                  color: ColorManager.hintTextColor,
                  ),
              ):null,
          hintText: widget.hintText,
          hintStyle: StyleManager.font16Regular(
            color: ColorManager.hintTextColor,
          )),
    );
  }
}
