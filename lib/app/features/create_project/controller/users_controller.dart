

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/app_constant.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/process_controller.dart';
import '../../profile/controller/profile_controller.dart';

class UsersController extends GetxController{

  final searchController = TextEditingController();
  Users users=Users(items: []);
  Users usersWithFilter=Users(items: []);
  var getUsers;
  String? uid;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getUsersFun();
    super.onInit();
    }

  getUsersFun() async {
    getUsers =_fetchUsersStream();
    return getUsers;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchUsersStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .where('typeUser',isEqualTo:AppConstants.collectionUser)
        .snapshots();
    return result;
  }
  filterUsers({required String term}) async {

    usersWithFilter.items=[];
    users.items.forEach((element) {
      Get.put(ProcessController()).cacheUser[element.uid??'']=element;
      if(element.uid!=uid)
      if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        usersWithFilter.items.add(element);
    });
     update();
  }



}
