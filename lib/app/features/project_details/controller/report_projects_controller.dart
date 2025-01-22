

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

import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';
import '../../profile/controller/profile_controller.dart';

class ReportProjectsController extends GetxController{

  final searchController = TextEditingController();
  ReportProjects reportProjects=ReportProjects(items: []);
  ReportProjects reportProjectsWithFilter=ReportProjects(items: []);
  String? uid;
  String? idProject;

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
        reportProjectsWithFilter.items.add(element);
    });
     update();
  }



}
