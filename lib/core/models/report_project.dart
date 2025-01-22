
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file_model.dart';

class ReportProject {
  String? id;
  String? idUser;
  String? idProject;
  String? nameUser;
  DateTime? dateTime;
  FileModel? file;

  ReportProject({
    this.id,
    this.nameUser,
    this.dateTime,
    this.file,
    this.idUser,
    this.idProject,
  });

  factory ReportProject.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    return ReportProject(
        id: data['id'],
      idUser: data["idUser"],
      dateTime: data["dateTime"]?.toDate(),
      nameUser: data["nameUser"],
      idProject: data["idProject"],
      file: data["file"]==null?null:FileModel.fromJson( data["file"]),
    );
  }

  factory ReportProject.init() {
    return ReportProject();
  }


  Map<String, dynamic> toJson() {
    return{
      'id': id,
    'nameUser': nameUser,
    'idUser': idUser,
    'idProject': idProject,
    'file': file?.toJson(),
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
  };
  }
}

///ReportProjects
class ReportProjects {
  List<ReportProject> items;



  ReportProjects({required this.items});

  factory ReportProjects.fromJson(json) {
    List<ReportProject> temp = [];
    for (int i = 0; i < json.length; i++) {
      ReportProject tempElement = ReportProject.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return ReportProjects(items: temp);
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