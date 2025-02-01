

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/models/report.dart';
import 'package:enjaz_app/core/models/report_project.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../core/models/file_model.dart';

import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/firebase/firebase_fun.dart';
import '../../profile/controller/profile_controller.dart';


class ReportProjectController extends GetxController{


  String? uid;
  ReportProject? reportProject;
  int currentProgress=0;
  int fullProgress=0;

  @override
  void onInit() {
    reportProject=ReportProject.init();
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

   super.onInit();
    }


  addReportProject(context,{FileModel? file,String? idProject,String? state}) async {
    // ConstantsWidgets.showProgress(progress);

    _calculateProgress(1);
    Get.dialog(
      GetBuilder<ReportProjectController>(
          builder: (ReportProjectController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${XFile(file?.localUrl??"").name??""}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
      if(file!=null){
        file.url=await FirebaseFun.uploadImage(image:XFile(file.localUrl??''),folder: FirebaseConstants.collectionReportProject+'/$id');
      _plusProgress();
    }
    ReportProject reportProject=ReportProject(
        id: id,
        idProject:idProject,
        idUser:uid,
        file:file,
        status:state,
        nameUser: Get.put(ProfileController()).currentUser?.value?.name,
        dateTime: DateTime.now()
    );
    var result=await FirebaseFun.addReportProject(reportProject:reportProject);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: id,typeUser: AppConstants.collectionWorker
      //     , subtitle: StringManager.notificationSubTitleNewProblem+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewProblem, message: ''));

      // Get.back();
    }
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }
  addReportProjectWithOutFile(context,{FileModel? file,String? idProject,String? state}) async {
    // ConstantsWidgets.showProgress(progress);

    _calculateProgress(1);
    Get.dialog(
      GetBuilder<ReportProjectController>(
          builder: (ReportProjectController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${XFile(file?.localUrl??"").name??""}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';

    ReportProject reportProject=ReportProject(
        id: id,
        idProject:idProject,
        idUser:uid,
        file:file,
        status:state,
        nameUser: Get.put(ProfileController()).currentUser?.value?.name,
        dateTime: DateTime.now()
    );
    var result=await FirebaseFun.addReportProject(reportProject:reportProject);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: id,typeUser: AppConstants.collectionWorker
      //     , subtitle: StringManager.notificationSubTitleNewProblem+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewProblem, message: ''));

      // Get.back();
    }
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
