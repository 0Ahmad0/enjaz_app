import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/routing/routes.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CheckInboxScreen extends StatelessWidget {
  const CheckInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AssetsManager.mailBoxIMG,
                  fit: BoxFit.cover,
                  width: 200.w,
                  height: 200.h
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.checkYourInboxText,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
                Text(
                  StringManager.sentEmailVerifyToResetPasswordText,
                  style:
                      StyleManager.font16Regular(color: ColorManager.hintTextColor),
                ),
                verticalSpace(30.h),
                AppButton(
                    onPressed: () {
                      context.pushReplacement(Routes.loginRoute);
                    },
                    text: StringManager.goToLoginText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
