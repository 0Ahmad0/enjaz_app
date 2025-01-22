

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/models/report.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../core/models/file_model.dart';

import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/firebase/firebase_fun.dart';
import '../../profile/controller/profile_controller.dart';


class ReportController extends GetxController{
  final formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController ;


  String? uid;
  ReportModel? report;
  int currentProgress=0;
  int fullProgress=0;

  @override
  void onInit() {
    report=ReportModel.init();
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

    descriptionController=TextEditingController( );
    // descriptionController=TextEditingController(text:person?.description );
    super.onInit();
    }


  addReport(context,{List<File?>? files,String? issue,String? description,String? contactOption,String? frequentlyAskedQuestion,bool? isSatisfied}) async {
    // ConstantsWidgets.showProgress(progress);
    _calculateProgress(files?.length??0);
    Get.dialog(
      GetBuilder<ReportController>(
          builder: (ReportController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${issue}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
    List<FileModel> files1=[];
    for(File? file in files??[]){
      if(file!=null){
        FileModel fileModel=FileModel();
        fileModel.url=await FirebaseFun.uploadImage(image:XFile(file.path??''),folder: FirebaseConstants.collectionReport+'/$id');
        if(fileModel.url!=null){
          fileModel=FileModel(
              name: XFile(file.path??'').name,
              localUrl: file.path,
              size: await file.length(),
              type: XFile(file.path??'').mimeType,
              subType:file.path.split('/').last.split('.').last
          );
          files1.add(fileModel);
        }
      }
      _plusProgress();
    }
    ReportModel reportModel=ReportModel(
        id: id,
        description:description,
        idUser:uid,
        files: files1??[],
        isSatisfied: isSatisfied,
        issue: issue,
        frequentlyAskedQuestion: frequentlyAskedQuestion,
        contactOption: contactOption,
        nameCustomer: Get.put(ProfileController()).currentUser?.value?.name,
        dateTime: DateTime.now()
    );
    var result=await FirebaseFun.addReport(report:reportModel);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: id,typeUser: AppConstants.collectionWorker
      //     , subtitle: StringManager.notificationSubTitleNewProblem+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewProblem, message: ''));

      Get.back();
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
  // updatePerson(context,{ XFile? image}) async {
  //   ConstantsWidgets.showLoading();
  //
  //   String name=nameController.value.text;
  //
  //   String? imagePath;
  //   if(image!=null){
  //     imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
  //   }
  //
  //   person?.name=name;
  //   person?.description= descriptionController.value.text;
  //  person?.imagePath=imagePath??person?.imagePath;
  //   person?.phoneNumber=phoneNumberController.value.text;
  //   person?.email=emailController.value.text;
  //   var
  //   result=await FirebaseFun.updatePerson(person:person!);
  //   ConstantsWidgets.closeDialog();
  //   // if(result['status'])
  //   //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }
  //


  // updateClassRoom(context,{required ClassRoomModel classRoom}) async {
  //   ConstantsWidgets.showLoading();
  //   var
  //   result=await FirebaseFun.updateClassRoom(classRoom:classRoom);
  //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }




  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }


}
