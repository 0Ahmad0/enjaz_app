

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


import '../../../../core/models/user_model.dart';
import '../../../../core/utils/style_manager.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';

class ProcessController extends GetxController {
  static ProcessController  get instance => Get.find();
  Map<String, dynamic> cacheNameUser = Map<String, dynamic>();
  Map<String, dynamic> cacheUser = Map<String, dynamic>();

  fetchLocalNameUser({required String idUser}) {
    //  print(cacheUser[idUser]);
    if (cacheNameUser.containsKey(idUser)) return cacheNameUser[idUser];
    return "......";
  }

  fetchNameUser(context, {required String idUser}) async {
    if (cacheNameUser.containsKey(idUser)) return cacheNameUser[idUser];
    var result = await FirebaseFun.fetchUserUid(
        uid: idUser, typeUser: FirebaseConstants.collectionUser);
    cacheNameUser[idUser] =
        (result['status']) ? UserModel.fromJson(result['body']).name :"delete account";//:tr(LocaleKeys.deleted_account);// ;
    update();
    return cacheNameUser[idUser];
  }

  UserModel? fetchLocalUser({required String idUser}) {
    if (cacheUser.containsKey(idUser)) return cacheUser[idUser];
    return null;
  }

  Future<UserModel?> fetchUser(context, {required String idUser}) async {
    if (cacheUser.containsKey(idUser) && cacheUser[idUser] != null)
      return cacheUser[idUser];
    var result = await FirebaseFun.fetchUserUid(
        uid: idUser, typeUser: FirebaseConstants.collectionUser);
    cacheUser[idUser] =
        (result['status']) ? UserModel.fromJson(result['body']) : null;
    update();
    return cacheUser[idUser];
  }

  void fetchUserAsync(context, {required String idUser}) async {
    if (cacheUser.containsKey(idUser) && cacheUser[idUser] != null)
      return cacheUser[idUser];
    var result = await FirebaseFun.fetchUserUid(
        uid: idUser, typeUser: FirebaseConstants.collectionUser);
    cacheUser[idUser] =
        (result['status']) ?result['body']!=null? UserModel.fromJson(result['body']) : null:null;
    update();
    return cacheUser[idUser];
  }

  fetchUsers(context, {required List<String> idUsers}) async {
    for (String idUser in idUsers) fetchUser(context, idUser: idUser);
    // notifyListeners();
  }

  widgetNameUser(context, {required String idUser,TextStyle? style}) {
    // if(cacheNameUser.containsKey(idUser)&&cacheNameUser[idUser]!=null)
    //   return Text('${cacheNameUser[idUser]}');
    return FutureBuilder(
      future: fetchNameUser(context, idUser: idUser),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return    CircularProgressIndicator();;
          // return    Text(tr(LocaleKeys.loading)+' ...');
          return    Text('جاري التحميل ...');
          // return    Text('loading ...');
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // return  Text(tr(LocaleKeys.deleted_account));
            return const Text('Error');
          } else if (snapshot.hasData) {
            // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
            //homeProvider.sessions=Sessions.fromJson(data['body']);
            return Text('${cacheNameUser[idUser]}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style??StyleManager.font18Medium(),
                );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
