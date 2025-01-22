
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file_model.dart';

class ReportModel {
  String? id;
  String? idUser;
  String? nameCustomer;
  DateTime? dateTime;
  List<FileModel>? files;
  bool?   isSatisfied;
  String? frequentlyAskedQuestion;
  String? contactOption;
  String? issue;
  String? description;

  ReportModel({
    this.id,
    this.nameCustomer,
    this.dateTime,
    this.files=const[],
    this.isSatisfied,
    this.idUser,
    this.contactOption,
    this.issue,
    this.frequentlyAskedQuestion,
    this.description,
  });

  factory ReportModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    List<FileModel> tempList = [];
    for(var file in data["files"]){
      tempList.add(FileModel.fromJson(file));
    }
    return ReportModel(
        id: data['id'],
      isSatisfied: data["isSatisfied"],

      idUser: data["idUser"],
      contactOption: data["contactOption"],
      dateTime: data["dateTime"]?.toDate(),
      description: data["description"],
      issue: data["issue"],
      frequentlyAskedQuestion: data["frequentlyAskedQuestion"],
      nameCustomer: data["nameCustomer"],
      files:tempList,
    );
  }

  factory ReportModel.init() {
    return ReportModel();
  }


  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempList = [];
    for(FileModel file in files??[]){
      tempList.add(file.toJson());
    }
    return{
      'id': id,
    'isSatisfied': isSatisfied,
    'idUser': idUser,
    'contactOption': contactOption,
    'issue': issue,
    'frequentlyAskedQuestion': frequentlyAskedQuestion,
    'description': description,
    'nameCustomer': nameCustomer,
    'files': tempList,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
  };
  }
}

///Reports
class Reports {
  List<ReportModel> items;



  Reports({required this.items});

  factory Reports.fromJson(json) {
    List<ReportModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      ReportModel tempElement = ReportModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Reports(items: temp);
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