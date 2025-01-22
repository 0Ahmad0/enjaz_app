import 'package:animate_do/animate_do.dart';

import '../../../../core/utils/assets_manager.dart';
import '../controller/auth_controller.dart';
import '/core/helpers/extensions.dart';
import '/core/routing/routes.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';
import '/core/widgets/app_textfield.dart';
import '/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  late AuthController authController;

  @override
  void initState() {
    authController = AuthController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: FadeInRight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20.h),
                Text(
                  StringManager.forgotPasswordText,
                  style: StyleManager.font24Medium(),
                ),
                verticalSpace(10.h),
                Text(
                  StringManager.pleaseEnterValidEmailText,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(40.h),
                Form(
                  key: formKey,
                  child: AppTextField(
                    controller: emailController,
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return StringManager.requiredField;
                      }
                      if(!value.isEmail){
                        return StringManager.pleaseEnterValidEmailText;
                      }
                      return null;
                    },
                    hintText: StringManager.enterEmailHintText,
                    iconData: AssetsManager.usernameIcon,
                  ),
                ),
                verticalSpace(40.h),
                AppButton(onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await authController.sendPasswordResetEmail(context, email: emailController.value.text);
                    print('Send Email ');
                  } else {
                    print('Error');
                  }

                }, text: StringManager.submitText)
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
