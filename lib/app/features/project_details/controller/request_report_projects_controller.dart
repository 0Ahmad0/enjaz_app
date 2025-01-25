

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/models/project_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/models/report_project.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/controllers/firebase/firebase_fun.dart';
import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';
import '../../profile/controller/profile_controller.dart';

class RequestReportProjectsController extends GetxController{

  final searchController = TextEditingController();
  ReportProjects reportProjects=ReportProjects(items: []);
  ReportProjects reportProjectsWithFilter=ReportProjects(items: []);
  String? uid;
  String? idProject;
  bool? isWorkManager;

  var getReportProjects;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getReportProjectsFun();
    super.onInit();
    }

  getReportProjectsFun() async {
    getReportProjects =_fetchReportProjectsStream();
    return getReportProjects;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchReportProjectsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionReportProject)
        .where('idProject',isEqualTo: idProject)
        .snapshots();
    return result;
  }
  filterReportProjects({required String term}) async {

    reportProjectsWithFilter.items=[];
    reportProjects.items.forEach((element) {

      if((element.file?.name?.toLowerCase().contains(term.toLowerCase())??false))


        if((isWorkManager??false)&&element.getStatus==null)
            reportProjectsWithFilter.items.add(element);
      else if(!(isWorkManager??false)&&element.getStatus!=AccountRequestStatus.Accepted&&element.idUser==uid)
          reportProjectsWithFilter.items.add(element);
    });
     update();
  }

  acceptOrRejectedRequest(context,{ReportProject? reportProject,String? state}) async {
    // ConstantsWidgets.showProgress(progress);

    reportProject?.status=state;
    var result=await FirebaseFun.updateReportProject(reportProject:reportProject!);

    // ConstantsWidgets.closeDialog();
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


}
