//Notification
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String idNotification;
  String? idUser;
  DateTime? dateTime;
  String? subtitle;
  String? typeUser;
  String title;
  String? message;
  bool checkSend;
  bool checkRec;
  NotificationModel({
    this.id="",
    this.idNotification='',
     this.idUser,
     this.typeUser,
    required this.subtitle,
    required this.dateTime,
    required this.title,
    required this.message,
    this.checkSend=false,
    this.checkRec=false,
  });

  factory NotificationModel.fromJson(json) {
    return NotificationModel(
      id: json['id'],
      idNotification: json['idNotification'],
      idUser: json['idUser'],
      typeUser: json['typeUser'],
      subtitle: json['subtitle'],
      title: json['title'],
      message: json['message'],
      checkSend: json['checkSend'],
      checkRec: json['checkRec'],
      dateTime: json['dateTime']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idNotification': idNotification,
      'typeUser': typeUser,
      'idUser': idUser,
      'subtitle': subtitle,
      'title': title,
      'message': message,
      'checkSend': checkSend,
      'checkRec': checkRec,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
    };
  }
  factory NotificationModel.init(){
    return NotificationModel( subtitle: '', dateTime: DateTime.now(), title: '', message: '');
  }
}

//Notifications
class Notifications {

  List<NotificationModel> items;

  //DateTime date;
  Notifications({
    required this.items});

  factory Notifications.fromJson(json) {
    List<NotificationModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      NotificationModel tempElement = NotificationModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Notifications(
        items: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in items) {
      temp.add(element.toJson());
    }
    return {
      'items': temp,
    };
  }
  factory Notifications.init()=>Notifications(items: []);
}
