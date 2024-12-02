import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';

import '../controller/auth_controller.dart';
import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/routing/routes.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';
import '/core/widgets/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(AuthController());
    // authController.init();
    return Scaffold(
      body: SafeArea(
        child: AppPaddingWidget(
          child: Form(
            child: SingleChildScrollView(
              child: FadeInLeft(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20.h),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AssetsManager.logoIMG,
                        width: 200.w,
                        height: 200.h,
                      ),
                    ),
                    verticalSpace(60.h),
                    AppTextField(
                      iconData: AssetsManager.usernameIcon,
                      // controller:  authController.emailController,
                      hintText: StringManager.enterEmailHintText,
                      // validator: (value)=>authController.validateEmail(value??'')
                    ),
                    verticalSpace(20.h),
                    AppTextField(
                      // controller: authController.passwordController,
                      obscureText: true,
                      suffixIcon: true,
                      iconData: AssetsManager.lockIcon,
                      // validator: (value)=>authController.validatePassword(value??''),
                      hintText: StringManager.enterPasswordHintText,
                    ),
                    verticalSpace(20.h),
                    AppButton(
                      onPressed: () {
                        // Seeder.serviceProvider();
                        // context.pushReplacement(Routes.navbarRoute);
                        // if (authController.formKey.currentState!.validate()) {
                        // authController.login(context);
                        // }
                      },
                      text: StringManager.loginText,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        onPressed: () {
                          context.pushNamed(Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          StringManager.forgotPasswordLoginText,
                          style: StyleManager.font14Regular(),
                        ),
                      ),
                    ),
                    verticalSpace(220.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: StringManager.doNotHaveAnAccountText + " ",
                            style: StyleManager.font14Bold(
                              color: ColorManager.blackColor,
                            ),
                          ),
                          TextSpan(
                              text: StringManager.createAccountNowText,
                              style: StyleManager.font14Regular(
                                color: ColorManager.blueColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushReplacement(Routes.signUpRoute);
                                }),
                        ]),
                      ),
                    )
                
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
