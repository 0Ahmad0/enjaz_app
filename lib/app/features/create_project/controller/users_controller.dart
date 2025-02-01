

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/process_controller.dart';
import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';
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


  connectionPerson(BuildContext context ,String? idUser) async {
    var result;
    ConstantsWidgets.showLoading();
    // if(person.idChat!=null){
    //   ConstantsWidgets.closeDialog();
    //   context.pushNamed(Routes.sendMessageRoute,
    //       arguments: {
    //         "index":index.toString(),
    //         'chat':Chat(id:person.idChat??'',messages: [], listIdUser: [uid??'',person.uid??''], date: DateTime.now())
    //       }
    //   );
    //
    // }
    // else
        {

      result = await Get.put(ChatController()).createChat(
          listIdUser: [uid??'',idUser ?? '']);
      /// bind person with user
      // if(result['status']){
      //   person.uid=user.uid;
      //   person.idChat=result['body']['id'];
      //   await FirebaseFun.updatePerson(person:person!);
      // }

      //TODO dd notification
      // if(result['status'])
      //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

      result =  await Get.put(ChatController()).fetchChatByListIdUser(
          listIdUser: [uid??'', idUser ?? '']);

      if(result['status']){
        ConstantsWidgets.closeDialog();
        // if(result['status'])
        //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
        Get.put(ChatRoomController()).chat=Get.put(ChatController()).chat;
        context.pop();
        context.pushNamed(Routes.messagesRoute,
            arguments: {
              'chat':Get.put(ChatController()).chat
            }
        );

      }else{
        ConstantsWidgets.closeDialog();
        ConstantsWidgets.TOAST(null,
            textToast: StringManager.errorTryAgainLater
            // textToast:  tr(LocaleKeys.message_error_try_again_later)
            , state: false);
      }
    }
    // else{
    //   await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
    //   ConstantsWidgets.closeDialog();
    // }

    // }

  }

}
