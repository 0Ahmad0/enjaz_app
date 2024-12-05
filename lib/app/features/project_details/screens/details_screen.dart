import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: AppPaddingWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VIP House Building',
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.network(
                  'https://mir-s3-cdn-cf.behance.net/project_modules/fs/e37de3152201755.6319b93ae5de3.jpg',
                  width: double.infinity,
                  height: 220.h,
                  fit: BoxFit.fill,
                ),
              ),
              verticalSpace(10.h),
              Text(
                StringManager.projectDescriptionText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              Container(
                padding: EdgeInsets.all(10.sp),
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 300.h, minHeight: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorManager.hintTextColor,
                    )),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: StyleManager.font12Regular(),
                ),
              ),
              verticalSpace(10.h),
              Text(
                StringManager.endDateText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: ColorManager.grayColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  DateFormat.yMd().format(
                    DateTime.now(),
                  ) + '  -  ${65} Day',
                ),
              ),
              verticalSpace(10.h),
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: StringManager.outOfDateText,
                    style: StyleManager.font16SemiBold(
                      color: ColorManager.errorColor
                    )
                  ),
                  TextSpan(
                    text: ' ' + StringManager.aiExpectationText
                  ),
                ]
              )),
              verticalSpace(10.h),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: ColorManager.grayColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text:  DateFormat.yMd().format(
                        DateTime.now(),
                      )+ ' - '
                    ),
                    TextSpan(
                      text: '${32} Day',
                      style: StyleManager.font14Regular(
                        color: ColorManager.errorColor
                      )
                    ),
                  ]
                )),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}
