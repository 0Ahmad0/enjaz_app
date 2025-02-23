import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../app/features/core/controllers/firebase/firebase_constants.dart';
import '../../app/features/core/controllers/firebase/firebase_fun.dart';
import '../enums/enums.dart';
import '../models/assets_project.dart';
import '../models/chat_model.dart';
import '../models/file_model.dart';
import '../models/image_project.dart';
import '../models/location_model.dart';
import '../models/message_model.dart';
import '../models/project_model.dart';
import '../models/report_project.dart';
import '../models/review_model.dart';
import '../models/user_model.dart';
import '../utils/app_constant.dart';
import '../utils/string_manager.dart';
import '../widgets/constants_widgets.dart';
import 'get_color_status_appointments.dart';

class Seeder{


  static Future<void> admin() async {

    try {
      // ConstantsWidgets.showLoading();
      for(UserModel userModel in adminsData){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;

          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }


  static Future<void> user() async {

    try {
      //ConstantsWidgets.showLoading();
      for(UserModel userModel in usersData){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;

          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }
  static Future<void> project() async {
    final random = Random();

    projects= List.generate(15, (index) {
      UserModel user = index%3==0?usersData.first:usersData[random.nextInt(usersData.length)];

      DateTime now = DateTime.now();
      DateTime startDate = now.add(Duration(days: random.nextInt(60) - 30)); // بين شهرين قبل وبعد
      DateTime endDate = startDate.add(Duration(days: random.nextInt(30) + 5)); // بعد start بحد أدنى 5 أيام
      DateTime selectDate = now;

      return ProjectModel(
        id: 'project_$index',
        idUser: user.uid,
        nameProject: 'Project ${index + 1}',
        urlPhoto: images[index % images.length],
        description: 'This is a description of Project ${index + 1}.',
        state: ProjectStatus.values[random.nextInt(ProjectStatus.values.length)].name,
        progress: random.nextDouble() ,
        selectDate: selectDate,
        startDate: startDate,
        endDate: endDate,
        location: LocationModel(
          latitude: 25.0 + random.nextDouble() * 10,
          longitude: 55.0 + random.nextDouble() * 10,
        ),
        members: [user.uid??'',...List.generate(random.nextInt(5) + 1, (_) => usersData[random.nextInt(usersData.length)].uid??"")],
        assets: _generateAssets(random.nextInt(10) + 1),
      );
    });
    try {
      //ConstantsWidgets.showLoading();
      for(ProjectModel item in projects){
        await FirebaseFun.addProject(project:item);
      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }
  static Future<void> imageProject() async {
    final random = Random();

    List<ImageProject> projectImages = List.generate(20, (index) {
      if (projects.isEmpty || usersData.isEmpty) return null;

      ProjectModel project = projects[random.nextInt(projects.length)];
      project.members=project.members??[usersData.first.uid??''];
      String uid=project.members![random.nextInt(project.members!.length)];
      UserModel? user = usersData.where((e)=>e.uid==uid).firstOrNull;
      // UserModel user = usersData[random.nextInt(usersData.length)];

      return ImageProject(
        id: 'image_$index',
        idUser: user?.uid,
        idProject: project.id,
        nameUser: user?.name,
        dateTime: DateTime.now().subtract(Duration(days: random.nextInt(30))),
        url: images[random.nextInt(images.length)],
      );
    }).whereType<ImageProject>().toList();

    try {
      for (ImageProject imageProject in projectImages) {
        await FirebaseFun.addImageProject(imageProject: imageProject);
      }
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      throw Exception(errorMessage);
    } on Exception {
      throw Exception();
    }
  }
  static Future<void> reportProject() async {
    final random = Random();

    List<ReportProject> projectReports = List.generate(15, (index) {
      if (projects.isEmpty || usersData.isEmpty || fileData==null) return null; // تأكد من وجود مشاريع ومستخدمين وملفات

      ProjectModel project = projects[random.nextInt(projects.length)];
      project.members=project.members??[usersData.first.uid??''];
      String uid=project.members![random.nextInt(project.members!.length)];
      UserModel? user = usersData.where((e)=>e.uid==uid).firstOrNull;
      // UserModel user = usersData[random.nextInt(usersData.length)];
      FileModel file = fileData;
      bool isWorkManager=project.idUser==user?.uid;
      String? status=isWorkManager?AccountRequestStatus.Accepted.name:[null,...AccountRequestStatus.values][random.nextInt(AccountRequestStatus.values.length+1)]?.name;
      return ReportProject(
        id: 'report_$index',
        idUser: user?.uid,
        idProject: project.id,
        nameUser: user?.name,
        dateTime: DateTime.now().subtract(Duration(days: random.nextInt(30))),
        file: file,
        status: status,
      );
    }).whereType<ReportProject>().toList();

    try {
      for (ReportProject reportProject in projectReports) {
        await FirebaseFun.addReportProject(reportProject: reportProject);
      }
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      throw Exception(errorMessage);
    } on Exception {
      throw Exception();
    }
  }


  static  Future<void> chat() async {

    final UserModel?  user=usersData.firstOrNull;
    final UserModel? admin=adminsData.firstOrNull;
    ProjectModel project = projects.where((e)=>e.members?.contains(user?.uid)??false).firstOrNull??projects[Random().nextInt(projects.length)];
    List<Chat>  chats= [];
    chats.add(await _generateGroupChat(project.nameProject??'',project.id??'',project.members??[]));
    project = projects[Random().nextInt(projects.length)];

    chats.add(await _generateGroupChat(project.nameProject??'',project.id??'',project.members??[]));
    // chats.add(await _generateChat(user?.uid??'', serviceProvider?.uid??''));
    // chats.add(await _generateChat("nSNs2Tt1G5PtZ2odeGQ0fBjKBLv2"??user?.uid??'', "xeM5IWakKCRpbnYggB3Jrbafx0Y2"??consultantProvider?.uid??''));

    try {
      //ConstantsWidgets.showLoading();
      for(Chat item in chats){

        var result=await FirebaseFun.addChat(chat:
        Chat(messages: [],name: item.name,idGroup: item.idGroup, listIdUser: item.listIdUser, date: DateTime.now()));
        if(result['status']){

          print(result);
          item.id=result['body']['id'];
          for(Message message in item.messages) {
            await FirebaseFun.addMessage(
                message: message, idChat:result['body']['id']);
          }

        }

      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }
  static  Future<void> file() async {

    try {
      // ConstantsWidgets.showLoading();

      fileData=FileModel(
          name: _xFile.name,
          localUrl:_xFile.path,
          size: 13260,
          type: TypeFile.file.name,
          subType: _xFile.mimeType,
          url:"https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/dummy.pdf?alt=media&token=5e97ac4a-2251-4431-b8ee-b5e6dab841e4"
      );
      imageData=FileModel(
          name: _xImage.name,
          localUrl:_xImage.path,
          size: 13096,
          type: TypeFile.image.name,
          subType: _xImage.mimeType,
          url: "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/%D8%B5%D9%88%D8%B1%D8%A91.gif?alt=media&token=d7bd9223-d6fb-4b78-a3fb-9619e5284d42"
      );
      // fileData=FileModel(
      //   name: _xFile.name,
      //   localUrl:_xFile.path,
      //   size: await _xFile.length(),
      //   type: TypeFile.file.name,
      //   subType: _xFile.mimeType,
      // );
      // imageData=FileModel(
      //   name: _xImage.name,
      //   localUrl:_xImage.path,
      //   size: await _xImage.length(),
      //   type: TypeFile.file.name,
      //   subType: _xImage.mimeType,
      // );
      //

      // fileData.url=await FirebaseFun.uploadImage(image:_xFile,folder:'');
      // imageData.url=await FirebaseFun.uploadImage(image:_xImage,folder:'');
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }

  static FileModel fileData=FileModel();
  static FileModel imageData=FileModel();
  static XFile _xFile = XFile("assets/dummy.pdf");
  static XFile _xImage = XFile("assets/images/logo.png");
  static List<UserModel> adminsData=[
    UserModel(email: 'admin@gmail.com', name: 'Super Admin', password: '12345678',phoneNumber: "0599555999", typeUser: AppConstants.collectionAdmin),
    UserModel(email: 'a@gmail.com', name: 'Admin Admin', password: '12345678',phoneNumber: "0599555999", typeUser: AppConstants.collectionAdmin),
  ];
  static List<UserModel> usersData=[
    UserModel(email: 'user@gmail.com', name: 'User T', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user2@gmail.com', name: 'Ahmad T1', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user3@gmail.com', name: 'Ahmad T2', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user4@gmail.com', name: 'Ahmad T3', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user5@gmail.com', name: 'Ahmad T4', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user6@gmail.com', name: 'Ahmad T5', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user7@gmail.com', name: 'Ahmad T6', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user8@gmail.com', name: 'Ahmad T7', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user9@gmail.com', name: 'Ahmad T8', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(email: 'user10@gmail.com', name: 'Ahmad T9', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),

  ];
  static List<String> assetNames = [
    'Toyota Corolla 2022',
    'MacBook Pro M1',
    'Dell XPS 15 Laptop',
    'Samsung Galaxy S23 Ultra',
    'Canon EOS R5 Camera',
    'DJI Mavic 3 Drone',
    'HP LaserJet Pro Printer',
    'Tesla Model 3',
    'Sony PlayStation 5',
    'Rolex Submariner Watch',
  ];
  static List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/Americas.png?alt=media&token=e044fcd7-0f89-4a13-8b7f-239d91fdb268",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/aaa.jpg?alt=media&token=11dda076-2185-485d-a48b-7cbaa8244661",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/d.jpg?alt=media&token=b90fd08b-35b1-4339-bfde-9042e9455d76",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/earth-5660940_960_720.png?alt=media&token=eb5e4f74-179b-4932-93c9-c7da1181744c",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/globe-1348777_1280.webp?alt=media&token=cfff61f7-6aaf-4ce1-b7e3-8aaa35be264d",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/qq.jpg?alt=media&token=db68f16d-4011-43b6-91ff-3f34d41593a0",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/qqq.jpg?alt=media&token=d5a20b83-2a53-4f3d-b639-2f904f2f8cfc",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/ss.jpg?alt=media&token=c6be1bd0-8008-4a58-aecb-74a42ab9d363",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/%D8%B5%D9%88%D8%B1%D8%A9%20%D8%AA%D8%AF%D9%84%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%86%D9%87%20%D9%84%D8%A7%20%D9%8A%D9%88%D8%AC%D8%AF%20%D8%A8%D9%8A%D8%A7%D9%86%D8%A7%D8%AA%20%D9%88%D8%AA%D9%83%D9%88%D9%86%20%D8%A7%D9%84%D8%B5%D9%88%D8%B1%D8%A9%20%D8%B9%D8%B5%D8%B1%D8%A8%D8%A9.png?alt=media&token=924e3c79-df11-4ed2-801b-9cdc8dbdea1f",
  ];
  static List<ProjectModel> projects = [];


  static _generateUid(String name){
    // return "$name${Timestamp.now().millisecondsSinceEpoch}";
    return '${name}00000'.substring(0,5)+'${Timestamp.now().microsecondsSinceEpoch}';
  }
  static _getRandomItem(List items){

    return items[Random().nextInt(items.length)];
  }

  static List<AssetsProject> _generateAssets(int count)  {
    return List.generate(count, (index) {
      int quantity = Random().nextInt(5) + 1;
      num price = ( Random().nextDouble() * 10000 + 500).toInt() as num;
      num total = quantity * price;

      return AssetsProject(
        id: 'asset_$index',
        idUser: usersData[ Random().nextInt(usersData.length)].uid,
        name: assetNames[index % assetNames.length],
        quantity: quantity.toString(),
        price: price,
        total: total,
        url: images[index % images.length],
        localUrl: null,
        dateTime: DateTime.now(),
      );
    });
  }


  static Future<Chat> _generateGroupChat(String projectName,String projectId, List<String> listIdUser) async {
    final random = Random();

    DateTime startTime = DateTime.now().subtract(Duration(minutes: 10));

    List<Map<String, dynamic>> chatData = [
      {'user1': "Hello everyone"},
      {'user2': "Hey, how is the project going?"},
      {'user3': "We need to review the technical progress"},
      {'user1': "Exactly, have we completed the data analysis?"},
      {'user4': "I finished the initial report, sending it now"},
      {'file': "Data Analysis Report"},
      {'user2': "Thanks, I will review it and provide feedback"},
      {'user5': "Any updates on the UI design?"},
      {'user3': "Yes, we have a prototype ready"},
      {'image': "UI Design"},
      {'user1': "Looks great! We will discuss it in the next meeting"},
      {'user4': "Any additional feedback on the system?"},
      {'user5': "I think we need to improve the user experience"},
      {'user2': "I agree, I will prepare a report on this"},
      {'file': "User Experience Analysis"},
      {'user1': "Great job, thank you all!"}
    ];

    List<Message> messages = [
      Message.init()
    ];

    for (var chat in chatData) {
      startTime = startTime.add(Duration(minutes: random.nextInt(5) + 1));
      String senderKey = chat.keys.first;
      String text = chat.values.first;
      String senderId = senderKey.startsWith("user")
          ? listIdUser[int.parse(senderKey.replaceAll("user", "")) % listIdUser.length]
          : ""; // Will be assigned later if it's a file
      TypeMessage typeMessage = TypeMessage.text;
      int? sizeFile;
      String? typeFile;
      String? localUrl;
      String? url;

      if (senderKey == "image") {
        typeMessage = TypeMessage.file;
        sizeFile = imageData.size;
        typeFile = TypeFile.image.name;
        localUrl = imageData.localUrl;
        url = imageData.url;
        senderId = listIdUser[random.nextInt(listIdUser.length)];
        text = (imageData.name ?? "") + '-${Timestamp.now().microsecondsSinceEpoch}';
      } else if (senderKey == "file") {
        typeMessage = TypeMessage.file;
        sizeFile = fileData.size;
        typeFile = TypeFile.file.name;
        localUrl = fileData.localUrl;
        url = fileData.url;
        senderId = listIdUser[random.nextInt(listIdUser.length)];
        text = (fileData.name ?? "") + '-${Timestamp.now().microsecondsSinceEpoch}';
      }

      messages.add(Message(
        textMessage: text,
        typeMessage: typeMessage.name,
        senderId: senderId,
        receiveId: projectId, // The chat is linked to the project
        sendingTime: startTime,
        sizeFile: sizeFile ?? 0,
        typeFile: typeFile,
        localUrl: localUrl ?? '',
        url: url ?? "",
      ));
    }

    return Chat(
      id: "chat_${Timestamp.now().seconds}",
      messages: messages,
      idGroup: projectId,
      name: projectName,
      listIdUser: listIdUser,
      date: DateTime.now(),
    );
  }


  static
  Future<Chat> _generateChat(String userId, String providerId) async {


    DateTime startTime = DateTime.now().subtract(Duration(minutes: 10));

    List<Map<String, dynamic>> chatData = [
      {'u': "Hi"},
      {'p': "Hello what can I do for you?"},
      {'u': "I have a problem with my car"},
      {'p': "What is the problem?"},
      {'u': "When I start the engine first it's trying to work then it starts fine"},
      {'p': "When was the last time you changed the battery?"},
      {'u': "Like a year ago"},
      {'p': "Go to a battery shop and check the battery"},
      {'u': "I bought this battery"},
      {'p': "Send me a picture of it"},
      {'u': "image"},
      {'p': "Ok nice, send me the invoice so I can see the details"},
      {'u': "file"},
      {'p': "It's excellent"},
      {'u': "Oh thank you"},
      {'p': "You're welcome"}
    ];

    List<Message> messages = [
      Message.init()
    ];

    for (var chat in chatData) {
      startTime = startTime.add(Duration(minutes: 1));
      String sender = chat.keys.first;
      String text = chat.values.first;
      String senderId = sender == 'u' ? userId : providerId;
      String receiverId = sender == 'u' ? providerId : userId;
      TypeMessage typeMessage = TypeMessage.text;
      int? sizeFile;
      String? typeFile;
      String? localUrl;
      String? url;

      if (text == "image") {
        typeMessage = TypeMessage.file;
        // typeMessage = TypeMessage.image;
        sizeFile = imageData.size;
        typeFile = TypeFile.image.name;
        localUrl = imageData.localUrl;
        url=imageData.url;
        text = (imageData.name??"") + '-${Timestamp.now().microsecondsSinceEpoch}';
      } else if (text == "file") {
        typeMessage = TypeMessage.file;
        sizeFile = fileData.size;
        typeFile = TypeFile.file.name;
        localUrl =fileData.localUrl;
        url=fileData.url;
        text =( fileData.name??"") + '-${Timestamp.now().microsecondsSinceEpoch}';
      }

      messages.add(Message(
        textMessage: text,
        typeMessage: typeMessage.name,
        senderId: senderId,
        receiveId: receiverId,
        sendingTime: startTime,
        sizeFile: sizeFile??0,
        typeFile: typeFile,
        localUrl: localUrl??'',
        url:url??"",
      ));
    }

    return Chat(
      id: "chat_${Timestamp.now().seconds}",
      messages: messages,
      listIdUser: [userId, providerId],
      date: DateTime.now(),
    );
  }


}