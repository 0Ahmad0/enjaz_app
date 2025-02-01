import 'package:enjaz_app/core/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/helpers/sizer.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';

class SenderTextWidget extends StatelessWidget {
  const SenderTextWidget({
    super.key, required this.text, required this.isCurrentUser, this.item,
  });
  final String text;
  final Message? item;
  final bool isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isCurrentUser?TextDirection.ltr:TextDirection.rtl,
      child: Align(
        alignment: AlignmentDirectional.centerStart,

        child: Padding(
          padding:  EdgeInsets.symmetric(
              vertical: 10.h
          ),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 12.h),
                constraints: BoxConstraints(
                    maxWidth: getWidth(context) / 1.75
                ),
                decoration: BoxDecoration(
                    color:isCurrentUser? ColorManager.blueColor:ColorManager.successColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r),
                      bottomRight:isCurrentUser? Radius.circular(14.r):Radius.zero,
                      bottomLeft: !isCurrentUser? Radius.circular(14.r):Radius.zero,
                    )),
                child: Text(
                  text,
                  style: StyleManager.font12Regular(
                      color: ColorManager.whiteColor),
                ),
              ),
              horizontalSpace(8.w),
              Text(
                intl.DateFormat().add_jm().format(
                    item?.sendingTime??
                    DateTime.now()),
                style: StyleManager.font10Bold(
                    color: ColorManager.hintTextColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
