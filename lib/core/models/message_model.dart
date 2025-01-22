import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  bool checkSend;
  num statSend;
  int index;
  String textMessage;
  int sizeFile;
  String url;
  // String urlTempPhoto;
  String localUrl;
  String typeMessage;
  String? typeFile;
  String senderId;
  String receiveId;
  // String replayId;
  DateTime? sendingTime;
  // List deleteUserMessage;
  Message(
      {this.id="",
        this.index=-1,
        this.sizeFile=0,
        this.checkSend=true,
        this.statSend=0,
        required this.textMessage,
        this.url="",
        // this.urlTempPhoto="",
        this.localUrl="",
        // required this.replayId,
        required this.typeMessage,
        required this.senderId,
        required this.receiveId,
         this.typeFile,
        // required this.deleteUserMessage,
        required this.sendingTime});
  factory Message.fromJson( json){
    // List<String> tempDeleteUserMessage = [];
    // for(String user in json["deleteUserMessage"]){
    //   tempDeleteUserMessage.add(user);
    // }
    String tempUrl="";
    if(!json["typeMessage"].contains('text')){
      tempUrl=json["url"];
    }
    String tempLocalUrl="";
    tempLocalUrl=json["localUrl"];
    // if(json.containsKey("localUrl")){
    //   tempLocalUrl=json["localUrl"];
    // }
    int tempSizeFile=0;
    tempSizeFile=json["sizeFile"];
    // if(json.containsKey("sizeFile")){
    //   tempSizeFile=json["sizeFile"];
    // }
    // String tempUrlTempPhoto="";
    // if(json.data().containsKey("urlTempPhoto")){
    //   tempUrlTempPhoto=json["urlTempPhoto"];
    // }
    return Message(
      url: tempUrl,
      localUrl: tempLocalUrl,
      textMessage: json["textMessage"],
      typeMessage: json["typeMessage"],
      sendingTime: json["sendingTime"].toDate(),
      senderId: json["senderId"],
      receiveId: json["receiveId"],
      index: json["index"],
      typeFile: json["typeFile"],
      // deleteUserMessage: tempDeleteUserMessage,
      // urlTempPhoto: tempUrlTempPhoto,
      sizeFile: tempSizeFile,
      // replayId: json["replayId"]
    );
  }
  Map<String,dynamic> toJson() {
    // List tempDeleteUserMessage = [];
    // for(String user in deleteUserMessage){
    //   tempDeleteUserMessage.add(user);
    // }

    return {
      'textMessage': textMessage,
      'typeMessage': typeMessage,
      'senderId': senderId,
      'receiveId': receiveId,
      'sendingTime': sendingTime==null?sendingTime:Timestamp.fromDate(sendingTime!),
      'index': index,
      'typeFile': typeFile,
      // 'deleteUserMessage': tempDeleteUserMessage,
      // 'urlTempPhoto': urlTempPhoto,
      'sizeFile': sizeFile,
      // 'replayId': replayId,
      'url': url,
      'localUrl': localUrl,
    };
  }
  factory Message.init(){
    return Message(textMessage: '', senderId: '', receiveId: '', sendingTime: DateTime.now(), typeMessage: 'text');
  }
}
//Messages
class Messages {
  List<Message> listMessage;



  Messages({required this.listMessage});

  factory Messages.fromJson(json) {
    List<Message> temp = [];
    for (int i = 1; i < json.length; i++) {
      Message tempElement = Message.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Messages(listMessage: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listMessage) {
      temp.add(element.toJson());
    }
    return {
      'listMessage': temp,
    };
  }
}