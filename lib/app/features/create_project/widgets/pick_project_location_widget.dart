import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickProjectLocationWidget extends StatelessWidget {
  const PickProjectLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Material(
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(14.r)),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          StringManager.pickLocationText,
                          style: StyleManager.font16SemiBold(
                              color: ColorManager.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            30.0,
                            35.235
                        )),
                  ))
                ],
              ),
              PositionedDirectional(
                end: 0,
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.whiteColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
