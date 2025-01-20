import 'package:enjaz_app/core/dialogs/delete_user_dialog.dart';
import 'package:enjaz_app/core/dialogs/uploade_file_dialog.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../../../core/utils/style_manager.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Visibility(
              //TODO : Show For Admin Only
              // visible: ,
              child: IconButton(
                onPressed: () {
                  //TODO : upload file tp project file
                  showDialog(
                    context: context,
                    builder: (context) => UploadFileDialog(

                    ),
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: ColorManager.successColor.withOpacity(
                    .15,
                  ),
                  child: Icon(
                    Icons.upload,
                  ),
                ),
              ),
            ),
            verticalSpace(30.h),
            Text(
              DateFormat().add_jm().format(DateTime.now()),
              style: StyleManager.font10Bold(color: ColorManager.hintTextColor),
            ),
          ],
        ),
        Container(
          padding: EdgeInsetsDirectional.only(start: 8.w, end: 8.w, top: 8.h),
          constraints: BoxConstraints(
            maxWidth: 250.w,
            maxHeight: 190.h,
          ),
          decoration: BoxDecoration(
            color: ColorManager.successColor,
            borderRadius: BorderRadius.circular(
              12.r,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: IgnorePointer(
                  child: PdfViewer.openAsset(
                    'assets/images/pdfCV.pdf',
                    params: PdfViewerParams(
                      padding: 0,
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 0),
                title: Text(
                  'file_name.pdf',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Regular(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
