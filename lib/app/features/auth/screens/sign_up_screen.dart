import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
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
var _borderTextFiled =
    ({Color color = ColorManager.primaryColor}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
        color: color,
        width: 1.sp
    ));

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  late List s;

  // late AuthController authController;

  @override
  void initState() {
    // authController.init();
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
              // key: authController.formKey,
              child: FadeInUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AssetsManager.logoIMG,
                        width: 120.w,
                        height: 120.h,
                      ),
                    ),
                    Text(StringManager.yourJobText,
                      style: StyleManager.font14Bold(),),
                    verticalSpace(8.h),
                    DropdownButtonFormField(
                      hint: Text(StringManager.selectTheTypeText,style: StyleManager.font16Regular(
                        color: ColorManager.hintTextColor,
                      ),),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h
                        ),
                        focusedBorder: _borderTextFiled(),
                        border: _borderTextFiled(color: Colors.transparent),
                        enabledBorder: _borderTextFiled(color: Colors.transparent),
                        errorBorder: _borderTextFiled(color: ColorManager.errorColor),
                        filled: true,
                        fillColor: ColorManager.grayColor,
                
                      ),
                      icon: Icon(Icons.keyboard_arrow_down,),
                        items: [1, 2, 3].map((e) =>
                            DropdownMenuItem(
                                child: Text(e.toString(),),
                              value: e.toString(),
                            )).toList(),
                        onChanged: (value) {}
                    ),
                    verticalSpace(10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringManager.firstNameText,
                                style: StyleManager.font14Bold(),),
                              verticalSpace(8.h),
                              AppTextField(
                                // iconData: AssetsManager.usernameIcon,
                                // controller: authController.nameController,
                                // validator: (value) =>
                                //     authController.validateFullName(value ?? ''),
                                hintText: StringManager.enterHereToTypeText,
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringManager.lastNameText,
                                style: StyleManager.font14Bold(),),
                              verticalSpace(8.h),
                              AppTextField(
                                // iconData: AssetsManager.usernameIcon,
                                // controller: authController.emailController,
                                // validator: (value) =>
                                //     authController.validateEmail(value ?? ''),
                                hintText: StringManager.enterHereToTypeText,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10.h),
                    Text(StringManager.userNameText,
                      style: StyleManager.font14Bold(),),
                    verticalSpace(8.h),
                    AppTextField(
                      // iconData: AssetsManager.usernameIcon,
                      // controller: authController.phoneController,
                      // validator: (value) =>
                      //     authController.validatePhoneNumber(value ?? ''),
                      hintText: StringManager.enterHereToTypeText,
                    ),
                    verticalSpace(10.h),
                    Text(StringManager.emailText,
                      style: StyleManager.font14Bold(),),
                    verticalSpace(8.h),
                    AppTextField(
                      // iconData: AssetsManager.usernameIcon,
                      // controller: authController.phoneController,
                      // validator: (value) =>
                      //     authController.validatePhoneNumber(value ?? ''),
                      hintText: StringManager.enterHereToTypeText,
                    ),
                    verticalSpace(10.h),
                    Text(StringManager.passwordText,
                      style: StyleManager.font14Bold(),),
                    verticalSpace(8.h),
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
                      hintText: StringManager.chooseStrongPasswordText,
                    ),
                    Visibility(
                      visible: passwordController.value.text.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10.h),
                            Text(
                              StringManager.conditionPasswordText,
                              style: StyleManager.font14SemiBold(),
                            ),
                            verticalSpace(10.h),
                            Column(
                              children: s
                                  .map((e) =>
                                  Row(
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
                    verticalSpace(10.h),
                    Text(StringManager.confirmPasswordText,
                      style: StyleManager.font14Bold(),),
                    verticalSpace(8.h),
                    AppTextField(
                      obscureText: true,
                      suffixIcon: true,
                      // controller: authController.confirmPasswordController,
                      // validator: (value) =>
                      //     authController.validatePassword(value ?? ''),
                      hintText: StringManager.rewritePasswordAgainText,
                    ),
                    verticalSpace(10.h),
                    Html(
                      data: StringManager.signUpHtmlData,
                
                    ),
                    verticalSpace(10.h),
                    AppButton(
                      onPressed: () {
                        // if (authController.formKey.currentState!.validate() &&
                        //     ConstValueManager.conditionPasswordList
                        //         .every((element) => element.isValidate)) {
                        // authController.signUp(context);
                        // }
                      },
                      text: StringManager.signUpText,
                    ),
                    verticalSpace(10.h),
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
      ),
    );
  }
}
