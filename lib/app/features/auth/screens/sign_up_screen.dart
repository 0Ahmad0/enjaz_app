import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/utils/const_value_manager.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  late List s;
  late AuthController authController;

  @override
  void initState() {
    authController.init();
    s = ConstValueManager.conditionPasswordList;
    Future.delayed(Duration(seconds: 2), () {
      passwordController.addListener(() {
        setState(() {
          s = ConstValueManager.conditionPasswordList;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
            child: Form(
              key: authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20.h),
                  Text(
                    StringManager.createAccountText,
                    style: StyleManager.font24Medium(),
                  ),
                  verticalSpace(40.h),
                  AppTextField(
                    iconData: Icons.person_outline,
                    controller: authController.nameController,
                    validator: (value) =>
                        authController.validateFullName(value ?? ''),
                    hintText: StringManager.enterNameHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.email_outlined,
                    controller: authController.emailController,
                    validator: (value) =>
                        authController.validateEmail(value ?? ''),
                    hintText: StringManager.enterEmailHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.call_outlined,
                    controller: authController.phoneController,
                    validator: (value) =>
                        authController.validatePhoneNumber(value ?? ''),
                    hintText: StringManager.enterPhoneHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return StringManager.requiredField;
                      } else {
                        s = Validator.validatePassword(value);
                      }
                      return null;
                    },
                    onChanged: (value) => s = Validator.validatePassword(value),
                    hintText: StringManager.enterSetPasswordHintText,
                  ),
                  verticalSpace(10.h),
                  Visibility(
                    visible: passwordController.value.text.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.conditionPasswordText,
                            style: StyleManager.font14SemiBold(),
                          ),
                          verticalSpace(10.h),
                          Column(
                            children: s
                                .map((e) => Row(
                                      children: [
                                        Icon(
                                          e.isValidate
                                              ? Icons.check_circle
                                              : Icons.circle,
                                          color: e.isValidate
                                              ? ColorManager.primaryColor
                                              : ColorManager.grayColor,
                                          size: 18.sp,
                                        ),
                                        horizontalSpace(8.w),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.h),
                                          child: Text(
                                            e.text,
                                            style: StyleManager.font12Regular(
                                              color: e.isValidate
                                                  ? ColorManager.primaryColor
                                                  : ColorManager.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: authController.confirmPasswordController,
                    validator: (value) =>
                        authController.validatePassword(value ?? ''),
                    hintText: StringManager.enterConfirmPasswordHintText,
                  ),
                  verticalSpace(10.h),
                  Html(
                    data: StringManager.signUpHtmlData,

                  ),
                  verticalSpace(20.h),
                  AppButton(
                    onPressed: () {
                      if (authController.formKey.currentState!.validate() &&
                          ConstValueManager.conditionPasswordList
                              .every((element) => element.isValidate)) {
                        // authController.signUp(context);
                      }
                    },
                    text: StringManager.signUpText,
                  ),
                  verticalSpace(20.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: StringManager.allReadyHaveAnAccountText + " ",
                        style: StyleManager.font14Regular(
                          color: ColorManager.blackColor,
                        ),
                      ),
                      TextSpan(
                          text: StringManager.loginText,
                          style: StyleManager.font14Bold(
                            color: ColorManager.primaryColor,
                          ).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorManager.primaryColor,
                              decorationThickness: 1),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(Routes.loginRoute);
                            }),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
