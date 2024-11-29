import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_button.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: FadeInUp(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                          StringManager.signOutText,
                          style: StyleManager.font20Bold(),
                        ),
                        verticalSpace(10.h),
                        Text(
                          StringManager.doYouWantToSignoutText,
                          style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
                        Row(
                          children: [
                            Flexible(
                                child: AppButton(
                              onPressed: () {
                              },
                              text: StringManager.signOutText,
                            )),
                            horizontalSpace(20.w),
                            Flexible(
                                child: AppOutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              text: StringManager.cancelText,
                            )),
                          ],
                        )
                      ],
                    ),
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Icon(Icons.close),
                        )

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
