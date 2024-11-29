import '/core/helpers/extensions.dart';
import '/core/helpers/sizer.dart';
import '/core/helpers/spacing.dart';
import '/core/routing/routes.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/const_value_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goToNextScreen(){
    Future.delayed(Duration(seconds: ConstValueManager.delayedSplash),(){
      context.pushReplacement(Routes.loginRoute);
    });
  }

  @override
  void initState() {
    _goToNextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              AssetsManager.logoIMG,
            ),
            const Spacer(),
            CircularProgressIndicator(
              color: ColorManager.blackColor.toMaterialColor(),
            ),
            verticalSpace(40.h),
            Text(
              StringManager.splashScreenText.toUpperCase(),
              textAlign: TextAlign.center,
              style: StyleManager.font16Regular(
                color: ColorManager.primaryColor
              ),
            ),
            verticalSpace(40.h),
          ],
        ),
      ),
    );
  }
}
