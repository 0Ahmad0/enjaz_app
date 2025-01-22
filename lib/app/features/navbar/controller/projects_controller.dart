

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/models/project_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';
import '../../profile/controller/profile_controller.dart';

class ProjectsController extends GetxController{

  final searchController = TextEditingController();
  Projects projects=Projects(items: []);
  Projects activeProject=Projects(items: []);
  Projects completedProjects=Projects(items: []);
  Projects projectsWithFilter=Projects(items: []);
  String? uid;

  var getProjects;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getProjectsFun();
    super.onInit();
    }

  getProjectsFun() async {
    getProjects =_fetchProjectsStream();
    return getProjects;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchProjectsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionProject)
        // .where('idUser',isEqualTo: uid)
        .snapshots();
    return result;
  }
  filterProviders({required String term}) async {

    projectsWithFilter.items=[];
    projects.items.forEach((element) {
      if((element.nameProject?.toLowerCase().contains(term.toLowerCase())??false))
        projectsWithFilter.items.add(element);
    });
     update();
  }
  classification() async {
    activeProject.items.clear();
    completedProjects.items.clear();
    projectsWithFilter.items.forEach((element) {

      switch(element.getState){
        case ProjectStatus.inProgress:
          activeProject.items.add(element);
        case  ProjectStatus.completed:
          completedProjects.items.add(element);
        default:
      }
      });
    update();
  }

  connectionPerson(BuildContext context ,String? idProvider) async {
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
            listIdUser: [uid??'',idProvider ?? '']);
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
            listIdUser: [uid??'', idProvider ?? '']);

        if(result['status']){
          ConstantsWidgets.closeDialog();
          // if(result['status'])
          //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
          Get.put(ChatRoomController()).chat=Get.put(ChatController()).chat;
          context.pushNamed(Routes.messagesRoute, arguments: {
            'chat':Get.put(ChatController()).chat
          });
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
