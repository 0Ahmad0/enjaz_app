
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/models/chat_model.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/firebase/firebase_fun.dart';




class ChatRoomController extends GetxController{
  Chat? chat  ;
  // Chat? chat = Get.arguments?["chat"] ;
  final messageController = TextEditingController();
  List<Message> chatList = [];
  List<Message> waitMessage = [];
  var getChat,getLastSeen;
  late  String currentUserId;
  String? recId;
  @override
  void onInit() {
    if(Get.arguments?["chat"] is Chat?){
      // chat=Get.arguments?["chat"];
    }
    waitMessage.clear();
    currentUserId=FirebaseAuth.instance.currentUser?.uid ?? '';
    recId=getIdUserOtherFromList( chat?.listIdUser??[]);
    getChatFun();
    getLastSeenFun();
    super.onInit();
    }

  getChatFun() async {
    getChat =_fetchChatStream(idChat: chat?.id??'');
    return getChat;
  }
  getLastSeenFun() async {
    getLastSeen =FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .doc(recId)
        .snapshots();
    return getLastSeen;
  }
  @override
  void dispose() {
    waitMessage.clear();
    messageController.dispose();
    super.dispose();
  }

  _fetchChatStream({required String idChat}) {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .collection(FirebaseConstants.collectionMessage)
        .orderBy("sendingTime")
        .snapshots();
    return result;

  }

  getIdUserOtherFromList(List<String> idUsers){
    String currentUserId=FirebaseAuth.instance.currentUser?.uid ?? '';
    for(String id in idUsers)
      if(id!=currentUserId)
        return id;
  }
  deleteChat(context,{required String idChat}) async{
    var result =await FirebaseFun
        .deleteChat(idChat: idChat);
    //ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  sendMessage(context,{required String idChat,required Message message}) async{
    var result;
    ///for check tweet
    waitMessage.add(message);
    update();
    String? filePath;
    if(message.localUrl.isNotEmpty){
      filePath=await FirebaseFun.uploadImage(image:XFile(message.localUrl!),folder: FirebaseConstants.collectionMessage+'/${message.textMessage}');
    }
    message.url=filePath??'';
     // result =await ApiService.processTweet(tweet: message.textMessage);

     // if(! result['status']){
     //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     //   return result;
     // }

    waitMessage.remove(message);
    update();

     ///...........................................

    if(message.typeMessage.contains(TypeMessage.text.name)){
      await FirebaseFun
          .addMessage(idChat: idChat,
          message:message);
    }else{
      if(result==null){
        result =await FirebaseFun
            .addMessage(idChat: idChat,
            message:message);
      }

    }
    return result;
  }
  deleteMessage(context,{required String idChat,required Message message}) async{
    var result =await FirebaseFun
        .deleteMessage(idChat: idChat,
        message:message);
    result['status']??ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

}
