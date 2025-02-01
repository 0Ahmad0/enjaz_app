import 'dart:io';

import 'package:enjaz_app/core/dialogs/delete_user_dialog.dart';
import 'package:enjaz_app/core/dialogs/uploade_file_dialog.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/widgets/constants_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/helpers/launcher_helper.dart';
import '../../../../core/models/file_model.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/utils/style_manager.dart';
import '../controller/chat_room_controller.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({super.key, this.item, required this.isCurrentUser, this.idGroup});
final Message? item;
  final bool isCurrentUser;
  final String? idGroup;
  @override
  Widget build(BuildContext context) {
    bool isLocal=((item?.url?.isEmpty??true));
    return Directionality(
      textDirection: !isCurrentUser?TextDirection.ltr:TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10.h
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [

               if( isLocal)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:   ConstantsWidgets.circularProgress()
                  )
                  else...[
                 Visibility(
                   visible: (item?.url.isNotEmpty??false)
                   &&  (idGroup?.isNotEmpty??false)
                   && (Get.put(ChatRoomController()).currentUserId.contains(
                           Get.put(ChatRoomController()).chat?.listIdUser.last??'-'
                       ))
                   ,
                   //TODO : Show For Admin Only
                   // visible: ,
                   child: IconButton(
                     onPressed: () {

                       FileModel fileModel=FileModel(
                           name:item?.textMessage,
                           localUrl: item?.localUrl,
                           size: item?.sizeFile,
                           type: TypeFile.file.name);
                       //TODO : upload file tp project file
                       showDialog(
                         context: context,
                         builder: (context) => UploadFileDialog(
                       fileModel:fileModel
                         ),
                       );
                     },
                     icon: CircleAvatar(
                       backgroundColor: ColorManager.successColor.withOpacity(
                         .15,
                       ),
                       child: Icon(
                         Icons.upload,
                         // Icons.upload,
                       ),
                     ),
                   ),
                 ),
                Visibility(
                  visible: item?.url.isNotEmpty??false,
                  //TODO : Show For Admin Only
                  // visible: ,
                  child: IconButton(
                    onPressed: () {
                      downloadFile(context,item!.url);
                      //TODO : upload file tp project file
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => UploadFileDialog(
                      //
                      //   ),
                      // );
                    },
                    icon: CircleAvatar(
                      backgroundColor: ColorManager.successColor.withOpacity(
                        .15,
                      ),
                      child: Icon(
                        Icons.file_download_rounded,
                        // Icons.upload,
                      ),
                    ),
                  ),
                )
               ],
                verticalSpace(30.h),
                Text(
                  intl.DateFormat().add_jm().format(
        item?.sendingTime??
                      DateTime.now()),
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
                color:isCurrentUser? ColorManager.blueColor:ColorManager.successColor,
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: IgnorePointer(
                      child:

                      ((item?.localUrl?.isNotEmpty??false)&&File(item!.localUrl).existsSync())?
                      PdfViewer.openFile(
                        item!.localUrl,
                        params: PdfViewerParams(
                          padding: 0,
                        ),
                      ):PdfViewer.openFile(
          item!.url,
          params: PdfViewerParams(
            padding: 0,
          ),
        )

                      ,
                        // PdfViewer.openAsset(
                        //   'assets/images/pdfCV.pdf',
                        //   params: PdfViewerParams(
                        //     padding: 0,
                        //   ),
                        // )
                    ),
                  ),
                  ListTile(

                    contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 0),
                    title: Text(
                      textAlign:isCurrentUser?TextAlign.end:TextAlign.start,
                      item?.textMessage??
                      'file_name.pdf',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Regular(

                      ).copyWith(color: isCurrentUser? ColorManager.whiteColor:null),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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


  Future<void> downloadFile(BuildContext context,String url) async {
    //TODO: Fix This
    final saveDir = await getDownloadDirectory();
    final fileUrl = url;
    final taskId = await FlutterDownloader.enqueue(
        url: fileUrl,
        savedDir: saveDir,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true).whenComplete((){
      LauncherHelper.launchWebsite(context, url);
    });

    print('Download started with taskId: $taskId');
  }
}
