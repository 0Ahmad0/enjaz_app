import '../../profile/controller/profile_controller.dart';
import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_padding.dart';
import '/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/widgets/app_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.changePasswordText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringManager.changePasswordText,
                  style: StyleManager.font14SemiBold(),
                ),
                verticalSpace(10.h),
                AppTextField(
                  controller: currentPasswordController,
                  hintText: StringManager.enterNewPasswordText,
                  suffixIcon: true,
                  obscureText: true,
                  validator: (String? val) {

                    if (val!.trim().isEmpty) return StringManager.requiredField;
                    if ( !(Get.put(ProfileController()).currentUser.value?.checkPassword(val)??false)) return StringManager.unCorrectPassword;
                    return null;
                  } ,
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.newPasswordText,
                  style: StyleManager.font14SemiBold(),
                ),
                verticalSpace(10.h),
                AppTextField(
                  controller: newPasswordController,
                  hintText: StringManager.enterNewPasswordText,
                  suffixIcon: true,
                  obscureText: true,
                ),
                verticalSpace(20.h),

                Text(
                  StringManager.confirmNewPasswordText,
                  style: StyleManager.font14SemiBold(),
                ),
                verticalSpace(10.h),
                AppTextField(
                  controller: confirmNewPasswordController,
                  hintText: StringManager.enterConfirmNewPasswordText,
                  suffixIcon: true,
                  obscureText: true,
                ),
                verticalSpace(20.h),
                Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: AppButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              Get.put(ProfileController()).changePassword(newPasswordController.value.text);

                            }
                          },
                          text: StringManager.saveChangesText,
                        )),
                    horizontalSpace(20.w),
                    Flexible(
                        flex: 2,
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
          ),
        ),
      ),
    );
  }
}
