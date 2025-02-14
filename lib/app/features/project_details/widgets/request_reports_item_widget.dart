import 'dart:io';

import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/enums/enums.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/models/report_project.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/image_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/dialogs/delete_dialog.dart';
import '../../../../core/dialogs/general_dialog.dart';
import '../../../../core/helpers/launcher_helper.dart';
import '../controller/request_report_projects_controller.dart';
import 'assets_details_box_widget.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class RequestReportsItemWidget extends StatefulWidget {
  const RequestReportsItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.date, this.url, this.item,
  });

  final String? image;
  final String name;
  final String date;
  final String? url;
  final ReportProject? item;

  @override
  State<RequestReportsItemWidget> createState() => _RequestReportsItemWidgetState();
}

class _RequestReportsItemWidgetState extends State<RequestReportsItemWidget> {
  String _pdfLink =
      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

  Future<void> requestPermissions() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      // الأذن تم رفضه
      print('Permission Denied');
    }
  }

  Future<String> getDownloadDirectory() async {
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/downloads';
    final saveDir = Directory(path);

    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    return saveDir.path;
  }

  Future<void> downloadFile() async {
    //TODO: Fix This
    final saveDir = await getDownloadDirectory();
    final fileUrl = _pdfLink;
    final taskId = await FlutterDownloader.enqueue(
        url: fileUrl,
        savedDir: saveDir,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true).whenComplete((){
      LauncherHelper.launchWebsite(context, _pdfLink);
    });

    print('Download started with taskId: $taskId');
  }

  @override
  Widget build(BuildContext context) {
    _pdfLink=widget.url?? _pdfLink;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: ColorManager.grayColor,
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 125.h,
          //   decoration: BoxDecoration(
          //     color: ColorManager.whiteColor,
          //     borderRadius: BorderRadius.circular(8.r),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.vertical(
          //       top: Radius.circular(8.r)
          //     ),
          //     child: IgnorePointer(
          //       ignoring: true,
          //       child: PdfViewer.openAsset(
          //         'assets/images/pdfCV.pdf',
          //         params: PdfViewerParams(
          //           pageDecoration: BoxDecoration()
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            width: double.infinity,
            height: 125.h,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              child: IgnorePointer(
                ignoring: true,
                child: FutureBuilder<File>(
                  future: DefaultCacheManager().getSingleFile(_pdfLink),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('خطأ: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return PdfViewer.openFile(
                        snapshot.data!.path,
                        params:
                            PdfViewerParams(pageDecoration: BoxDecoration()),
                      );
                    } else {
                      return const Center(child: Text('تعذر تحميل الملف.'));
                    }
                  },
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading:
            ImageUserProvider(url: widget.image??"",),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(widget.image),
            // ),
            title: Text(
              widget.name,
              style: StyleManager.font14Bold(),
            ),
            subtitle: Text(
              widget.date,
              style: StyleManager.font12SemiBold(
                  color: ColorManager.hintTextColor),
            ),
            trailing: InkWell(
                onTap: downloadFile,
                child: SvgPicture.asset(
                  AssetsManager.fileDownloadIcon,
                  width: 30.w,
                  height: 30.h,
                )),
          ),
          horizontalSpace(10.w),
          if(widget.item?.getStatus==null&&(Get.put(RequestReportProjectsController()).isWorkManager??false))
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          GeneralDialog(
                            title: StringManager.acceptText,
                            subTitle: StringManager.areYouSureApprovedRequestText,
                            onOkTap: () {
                              context.pop();
                              Get.put(RequestReportProjectsController()).acceptOrRejectedRequest(context,reportProject:widget.item, state:AccountRequestStatus.Accepted.name, );
                            },
                          ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.successColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      StringManager.acceptText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.whiteColor),
                    ),
                  ),
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          DeleteDialog(
                            title: StringManager.cancelText,
                            subTitle: StringManager.areYouSureRejectRequestText,
                            onDeleteTap: () {
                              context.pop();
                              Get.put(RequestReportProjectsController()).acceptOrRejectedRequest(context,reportProject:widget.item, state:AccountRequestStatus.Rejected.name, );
                            },
                          ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.errorColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      StringManager.cancelText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.errorColor),
                    ),
                  ),
                ),
              ),
            ],
          )
          else
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color:
                widget.item?.getStatus==AccountRequestStatus.Accepted?
                ColorManager.successColor
                :widget.item?.getStatus==AccountRequestStatus.Rejected?
                ColorManager.errorColor:
                ColorManager.blueColor
                ,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                widget.item?.getStatus?.name??"Pending",
                style: StyleManager.font14Regular(
                    color: ColorManager.whiteColor),
              ),
            ),
        ],
      ),
    );
  }
}
