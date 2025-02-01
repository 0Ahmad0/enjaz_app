import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import '../../app/features/messages/controller/chat_room_controller.dart';
import '../../app/features/project_details/controller/report_project_controller.dart';
import '../enums/enums.dart';
import '../models/file_model.dart';
import '/core/helpers/extensions.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UploadFileDialog extends StatelessWidget {
   UploadFileDialog({super.key, this.fileModel});
final  FileModel? fileModel;
  // final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: FadeInUp(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'upload file',
                          style: StyleManager.font18SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Text(
                          'Are you sure upload this file?',
                          textAlign: TextAlign.center,
                          style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
                        Row(
                          children: [
                            Flexible(
                                child: AppOutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              text: StringManager.cancelText,
                            )),
                            horizontalSpace(10.w),
                            Flexible(
                                child: AppButton(
                              color: ColorManager.successColor,
                              onPressed: () {
                                context.pop();
                                Get.put(ReportProjectController()).addReportProjectWithOutFile(context,file: fileModel,idProject: Get.put(ChatRoomController()).chat?.idGroup
                                ,state:AccountRequestStatus.Accepted.name);
                                //ToDo : Upload File
                              },
                              text: 'upload',
                            )),
                          ],
                        )
                      ],
                    ),
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
