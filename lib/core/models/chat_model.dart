import 'message_model.dart';

class Chat {
  String id;
  List<Message> messages;
  List<String> listIdUser;
  DateTime date;

  Chat({
    this.id='',
    required this.messages,
    required this.listIdUser,
    required this.date,
  });
  factory Chat.fromJson( json){
    List<Message> listTemp = [];
    // for(int i=1;i<json['messages'].length;i++){
    //   Message tempMessage=Message.fromJson(json['messages'][i]);
    //   tempMessage.id=json['messages'][i].id;
    //   listTemp.add(tempMessage);
    // }
    List<String> listTemp2=[];
    for(String temp in json['listIdUser'])
      listTemp2.add(temp);
    return Chat(
      id: json['id'],
      listIdUser: listTemp2,
      messages: listTemp,//json["messages"],
      date: json["date"].toDate(),
    );
  }

  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> listTemp = [];
    for(Message message in messages){
      listTemp.add(message.toJson());
    }
    return {
      'id':id,
      'date':date,
      // 'messages':listTemp,
      'listIdUser':listIdUser,
    };
  }
  factory Chat.init(){
    return Chat(messages: [], listIdUser: [], date: DateTime.now());
  }
}

//Chats
class Chats {
  List<Chat> listChat;

  //DateTime date;

  Chats({required this.listChat});

  factory Chats.fromJson(json) {
    List<Chat> temp = [];

    for (int i = 0; i < json.length; i++) {
      Chat tempElement = Chat.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Chats(listChat: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listChat) {
      temp.add(element.toJson());
    }
    return {
      'listChat': temp,
    };
  }
}