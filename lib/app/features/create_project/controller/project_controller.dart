

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/models/assets_project.dart';
import 'package:enjaz_app/core/models/location_model.dart';
import 'package:enjaz_app/core/models/project_model.dart';
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


class ProjectController extends GetxController{
  final formKey = GlobalKey<FormState>();


  String? uid;
  ProjectModel? project;
  int currentProgress=0;
  int fullProgress=0;

  @override
  void onInit() {
    project=ProjectModel.init();
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

    // descriptionController=TextEditingController( );
    // descriptionController=TextEditingController(text:person?.description );
    super.onInit();
    }


  addProject(context,{File? image,String? nameProject,String? description,DateTime? startDate,DateTime? endDate,LocationModel? location}) async {
    // ConstantsWidgets.showProgress(progress);
    _calculateProgress(project?.assets?.length??0);
    Get.dialog(
      GetBuilder<ProjectController>(
          builder: (ProjectController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${nameProject}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
    List<AssetsProject> files1=[];
    for(AssetsProject assetsProject in project?.assets??[]){
      if(assetsProject.localUrl?.isNotEmpty??false){
        // assetsProject.url="https://th.bing.com/th/id/R.82db4dad4b670e47f900ac49909d93c9?rik=WwFfg23Q7OeD%2bw&pid=ImgRaw&r=0";
        assetsProject.url=await FirebaseFun.uploadImage(image:XFile(assetsProject.localUrl??''),folder: FirebaseConstants.collectionProject+'/$id');
        if(assetsProject.url!=null){
          files1.add(assetsProject);
        }
      }
      _plusProgress();
    }
    String? imagePath;
    if(image!=null){
      // imagePath="https://aigeeked.com/wp-content/uploads/2022/12/ai-image-generator.jpg";
      imagePath=await FirebaseFun.uploadImage(image:XFile(image.path),folder: FirebaseConstants.collectionProject+'/$nameProject');
    }
    if((uid?.isNotEmpty??false)&&!(project?.members?.contains(uid)??false))
      project?.members?.add(uid!);
    ProjectModel projectModel=ProjectModel(
        id: id,
       urlPhoto:imagePath ,
        description:description,
        idUser:uid,
        assets: files1??[],
        members: project?.members??[],
        nameProject: nameProject,
        startDate: startDate,
        endDate: endDate,
        location: location,
        selectDate: DateTime.now()
    );
    var result=await FirebaseFun.addProject(project:projectModel);

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


  addAsset(XFile file,{String? name,String? quantity,num? price,num? total}) async {
    project?.assets??=[];
    project?.assets?.add(AssetsProject(
        name: name??file.name,
        localUrl: file.path,
        price:price,
        quantity: quantity,
        total:total,
      idUser: uid,
    ));
    update();
  }
  removeAsset(AssetsProject asset) async {
    project?.assets?.remove(asset);
    update();
  }


  addMember({String? idUser}) async {
    if(idUser!=null)
    project?.members?.add(idUser);
    update();
  }
  removeMember(String? idUser) async {
    project?.members?.remove(idUser);
    update();
  }


  @override
  void dispose() {
    // descriptionController.dispose();
    super.dispose();
  }


}
