
import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/enums.dart';
import 'file_model.dart';

class ImageProject {
  String? id;
  String? idUser;
  String? idProject;
  String? nameUser;
  DateTime? dateTime;
  String? url;


  ImageProject({
    this.id,
    this.nameUser,
    this.dateTime,
    this.url,
    this.idUser,
    this.idProject,

  });

  factory ImageProject.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    return ImageProject(
        id: data['id'],
      idUser: data["idUser"],
      dateTime: data["dateTime"]?.toDate(),
      nameUser: data["nameUser"],
      idProject: data["idProject"],
      url: data["url"],
    );
  }

  factory ImageProject.init() {
    return ImageProject();
  }


  Map<String, dynamic> toJson() {
    return{
      'id': id,
    'nameUser': nameUser,
    'idUser': idUser,
    'idProject': idProject,
    'url': url,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
  };
  }
}

///imageProjects
class ImageProjects {
  List<ImageProject> items;



  ImageProjects({required this.items});

  factory ImageProjects.fromJson(json) {
    List<ImageProject> temp = [];
    for (int i = 0; i < json.length; i++) {
      ImageProject tempElement = ImageProject.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return ImageProjects(items: temp);
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
}