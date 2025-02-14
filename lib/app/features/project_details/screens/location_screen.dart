import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/launcher_helper.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../create_project/controller/project_controller.dart';
import '../../show_location_on_map/screens/show_location_on_map_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final location= Get.put(ProjectController()).project?.location;
    return ZoomIn(
      child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10.h),
              Container(
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color: ColorManager.grayColor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: QrImageView(data: "https://www.google.com/maps/search/?api=1&query=${location?.latitude??24.56},${location?.longitude??46.215}",
                        version: QrVersions.auto,
                        size: 300.h,
                        gapless: true,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/qr.png',
                    //   width: double.infinity,
                    //   height: 300.h,
                    // ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.scanQrToGetMapText,
                      style: StyleManager.font14Bold(),
                    ),
                    const Divider(),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: StringManager.orPressOnTheLinkText + ' ',
                              style: StyleManager.font14Bold()),
                          TextSpan(
                              text: StringManager.hereText,
                              style: StyleManager.font14Bold(
                                  color: ColorManager.blueColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              showLocationOnMapScreen(
                                                latitude: location?.latitude??24.56 ,
                                                longitude:location?.longitude??46.215,
                                              )));
                                }),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
