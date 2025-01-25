

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/models/report.dart';
import 'package:enjaz_app/core/models/report_project.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../core/models/file_model.dart';

import '../../../../core/models/image_project.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/firebase/firebase_fun.dart';
import '../../profile/controller/profile_controller.dart';


class ImageProjectController extends GetxController{


  String? uid;
  ImageProject? imageProject;
  int currentProgress=0;
  int fullProgress=0;

  @override
  void onInit() {
    imageProject=ImageProject.init();
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

   super.onInit();
    }


  addImageProject(context,{List<XFile>? files,String? idProject}) async {
    // ConstantsWidgets.showProgress(progress);

    _calculateProgress(files?.length??0);
    Get.dialog(
      GetBuilder<ImageProjectController>(
          builder: (ImageProjectController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );
    var result;
    for(XFile file in files??[]){
      String id= '${XFile(file?.path??"").name??""}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
      String? url;
      if(file!=null){
        url=await FirebaseFun.uploadImage(image:XFile(file.path??''),folder: FirebaseConstants.collectionReportProject+'/$id');
        _plusProgress();
      }
      if(url?.isEmpty??true)
        return;
      ImageProject imageProject=ImageProject(
          id: id,
          idProject:idProject,
          idUser:uid,
          url:url,
          nameUser: Get.put(ProfileController()).currentUser?.value?.name,
          dateTime: DateTime.now()
      );
       result=await FirebaseFun.addImageProject(imageProject:imageProject);

    }

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: id,typeUser: AppConstants.collectionWorker
      //     , subtitle: StringManager.notificationSubTitleNewProblem+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewProblem, message: ''));

      // Get.back();
    }
    else
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }


  _calculateProgress(int length){
    currentProgress=0;
    fullProgress=1;
    fullProgress+=length;
    update();
  }
  _plusProgress(){
    currentProgress++;
    if(currentProgress>fullProgress)
      currentProgress=fullProgress;
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }


}
