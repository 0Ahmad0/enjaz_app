
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/core/models/assets_project.dart';
import 'package:enjaz_app/core/models/report_project.dart';
import 'package:intl/intl.dart';

import '../enums/enums.dart';
import 'location_model.dart';

class ProjectModel {
  String? id;
  String? idUser;
  String? nameProject;
  String? urlPhoto;
  String? description;
  String? state;
  num? progress;
  DateTime? selectDate;
  DateTime? startDate;
  DateTime? endDate;
  LocationModel? location;
  List<String>? members;
  List<ReportProject>? reports;
  List<AssetsProject>? assets;

  ProjectModel({
    this.id,
    this.idUser,
    this.nameProject,
    this.urlPhoto,
    this.description,
    this.state,
    this.progress,
    this.selectDate,
    this.startDate,
    this.endDate,
    this.location,
    this.members,
    this.reports,
    this.assets,
  });

  factory ProjectModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    List<String> tempList = [];
    List<ReportProject> tempListReport = [];
    List<AssetsProject> tempListAssets = [];
    for(var element in data["members"]){
      tempList.add(element);
    }
    for(var element in data["assets"]){
      tempListAssets.add(AssetsProject.fromJson(element));
    }
    for(var element in data["reports"]){
      tempListReport.add(ReportProject.fromJson(element));
    }
    return ProjectModel(
        id: data['id'],
      idUser: data["idUser"],
      state: data["state"],
        selectDate: data["selectDate"]?.toDate(),
      startDate: data["startDate"]?.toDate(),
      endDate: data["endDate"]?.toDate(),
      nameProject: data["nameProject"],
      urlPhoto: data["urlPhoto"],
      description: data["description"],
      members: tempList,
      assets: tempListAssets,
      reports: tempListReport,
      progress: num.tryParse("${data["progress"]}"),
      location: data["location"]==null?null:LocationModel.fromJson(data["location"]),
    );
  }

  factory ProjectModel.init() {
    return ProjectModel(reports: [],members: [],assets: []);
  }

  // int? get getStateInt{
  //   DateTime now=DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now()));
  //
  //   if(selectDate==null||state==null)
  //     return 1;
  //   DateTime? current=DateFormat.yMd().parse(DateFormat.yMd().format(selectDate!));
  //   if(now.isAfter(current!)
  //       ||[ColorAppointments.Canceled.name,ColorAppointments.Concluded.name,ColorAppointments.Rejected.name].contains(state))
  //     return -1;
  //   if(now.isBefore(current!)
  //       ||[ColorAppointments.StartingSoon.name,ColorAppointments.Ongoing.name,ColorAppointments.Pending.name].contains(state))
  //     return 1;
  //   if(now.isAtSameMomentAs(current!))
  //     return 0;
  //   else
  //     return 1;
  // }
  ProjectStatus? get getState{
    DateTime now=DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now()));

    if(selectDate==null||state==null)
      return ProjectStatus.inProgress;
    // DateTime? start=DateFormat.yMd().parse(DateFormat.yMd().format(startDate!));
    // DateTime? end=DateFormat.yMd().parse(DateFormat.yMd().format(endDate!));
   //  if([ColorAppointments.Canceled.name,ColorAppointments.Concluded.name,ColorAppointments.Rejected.name,ColorAppointments.StartingSoon].contains(state))
   return ProjectStatus.values.where((e)=>e.name.contains(state??"")).first;
   //  if(now.isBefore(start!))
   //    return ProjectStatus.inProgress;
   //  if(now.isAfter(current!))
   //    return ColorAppointments.Canceled;
   //  if(now.isAtSameMomentAs(current!))
   //    return  ColorAppointments.Ongoing;
   //  else
   //      return  ColorAppointments.Ongoing;
  }
  // String? get getStateArabic{
  //   switch(getState??ColorAppointments.Pending){
  //     case ColorAppointments.Pending:
  //       return "معلق";
  //     case ColorAppointments.Ongoing:
  //       return "قيد المعالجة";
  //     case ColorAppointments.Rejected:
  //       return "مرفوض";
  //     case ColorAppointments.StartingSoon:
  //       return "يبدأ قريبا";
  //     case ColorAppointments.Concluded:
  //       return "منتهي";
  //     case ColorAppointments.Canceled:
  //       return "ملغى";
  //
  //   }
  //
  // }


  Map<String, dynamic> toJson() {
    List<String> tempList = [];
    List<Map<String, dynamic>> tempListAssets = [];
    List<Map<String, dynamic>> tempListReport = [];
    for(String element in members??[]){
      tempList.add(element);
    }
    for(AssetsProject element in assets??[]){
      tempListAssets.add(element.toJson());
    }
    for(ReportProject element in reports??[]){
      tempListReport.add(element.toJson());
    }

    return{
      'id': id,

    'idUser': idUser,
    'nameProject': nameProject,
    'urlPhoto': urlPhoto,
    'state': state,
    'description': description,
    'progress': progress,
    'reports': tempListReport,
    'assets':tempListAssets ,
    'members': tempList,
    'location': location?.toJson(),
      'selectDate': selectDate==null?null:Timestamp.fromDate(selectDate!),
      'startDate': startDate==null?null:Timestamp.fromDate(startDate!),
      'endDate': endDate==null?null:Timestamp.fromDate(endDate!),
  };
  }
}

///Projects
class Projects {
  List<ProjectModel> items;



  Projects({required this.items});

  factory Projects.fromJson(json) {
    List<ProjectModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      ProjectModel tempElement = ProjectModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Projects(items: temp);
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