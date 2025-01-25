import 'dart:ui' as ui;

import 'package:animate_do/animate_do.dart';
import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GeneralDialog extends StatelessWidget {
  final VoidCallback? onOkTap;
  final String title;
  final String subTitle;
  final String cancelText;
  final String okText;

  const GeneralDialog({
    super.key,
    this.onOkTap,
    required this.title,
    required this.subTitle,
    this.cancelText = StringManager.cancelText,
    this.okText = StringManager.okText,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: FadeInUp(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          title,
                          style: StyleManager.font18SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Text(
                          subTitle,
                          textAlign: TextAlign.center,
                          style: StyleManager.font14Regular(
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        verticalSpace(10.h),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                  cancelText,
                                style: StyleManager.font14Regular(),
                              ),
                            ),
                            horizontalSpace(10.w),
                            Flexible(
                                child: TextButton(
                              onPressed: onOkTap,
                              child: Text(
                                okText,
                                style: StyleManager.font14SemiBold(
                                    color: ColorManager.successColor),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
