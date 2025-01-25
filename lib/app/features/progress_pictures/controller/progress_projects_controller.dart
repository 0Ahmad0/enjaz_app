

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/models/project_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/models/image_project.dart';
import '../../../../core/models/report_project.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';
import '../../profile/controller/profile_controller.dart';

class ProgressProjectsController extends GetxController{

  final searchController = TextEditingController();
  ImageProjects imageProjects=ImageProjects(items: []);
  ImageProjects imageProjectsWithFilter=ImageProjects(items: []);
  String? uid;
  String? idProject;

  var getImageProjects;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getImageProjectsFun();
    super.onInit();
    }

  getImageProjectsFun() async {
    getImageProjects =_fetchImageProjectsStream();
    return getImageProjects;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchImageProjectsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionImageProject)
        .where('idProject',isEqualTo: idProject)
        .snapshots();
    return result;
  }
  filterImageProjects({required String term}) async {

    imageProjectsWithFilter.items=[];
    imageProjects.items.forEach((element) {
      // if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        imageProjectsWithFilter.items.add(element);
    });
     update();
  }



}
