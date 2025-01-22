//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tools_to_go_app/core/models/location_model.dart';
//
// import '../helpers/get_color_status_appointments.dart';
// import '../utils/app_constant.dart';
// import 'file_model.dart';
//
// class Appointment {
//   String? id;
//   String? idTool;
//   String? idWorker;
//   String? nameWorker;
//   String? idOwner;
//   String? idUser;
//   String? nameCustomer;
//   String? state;
//   DateTime? selectDate;
//   LocationModel? deliveryAddress;
//   bool   withDelivery;
//   String? specialInstructions;
//   String? nameTool;
//
//   Appointment({
//     this.id,
//     this.idTool,
//     this.idWorker,
//     this.nameWorker,
//     this.idOwner,
//     this.idUser,
//     this.state,
//     this.selectDate,
//     this.deliveryAddress,
//     this.withDelivery=false,
//     this.specialInstructions,
//     this.nameTool,
//     this.nameCustomer,
//   });
//
//   factory Appointment.fromJson(json) {
//     var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
//
//     return Appointment(
//         id: data['id'],
//       idTool: data["idTool"],
//       idWorker: data["idWorker"],
//       nameWorker: data["nameWorker"],
//       idOwner: data["idOwner"],
//       idUser: data["idUser"],
//       state: data["state"],
//         selectDate: data["selectDate"]?.toDate(),
//       withDelivery: data["withDelivery"],
//       specialInstructions: data["specialInstructions"],
//       nameTool: data["nameTool"],
//       nameCustomer: data["nameCustomer"],
//       deliveryAddress: data["deliveryAddress"]==null?null:LocationModel.fromJson(data["deliveryAddress"]),
//     );
//   }
//
//   factory Appointment.init() {
//     return Appointment();
//   }
//
//   int? get getStateInt{
//     DateTime now=DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now()));
//
//     if(selectDate==null||state==null)
//       return 1;
//     DateTime? current=DateFormat.yMd().parse(DateFormat.yMd().format(selectDate!));
//     if(now.isAfter(current!)
//         ||[ColorAppointments.Canceled.name,ColorAppointments.Concluded.name,ColorAppointments.Rejected.name].contains(state))
//       return -1;
//     if(now.isBefore(current!)
//         ||[ColorAppointments.StartingSoon.name,ColorAppointments.Ongoing.name,ColorAppointments.Pending.name].contains(state))
//       return 1;
//     if(now.isAtSameMomentAs(current!))
//       return 0;
//     else
//       return 1;
//   }
//   ColorAppointments? get getState{
//     DateTime now=DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now()));
//
//     if(selectDate==null||state==null||([ColorAppointments.Pending.name].contains(state)))
//       return ColorAppointments.Pending;
//     DateTime? current=DateFormat.yMd().parse(DateFormat.yMd().format(selectDate!));
//     if([ColorAppointments.Canceled.name,ColorAppointments.Concluded.name,ColorAppointments.Rejected.name,ColorAppointments.StartingSoon].contains(state))
//    return ColorAppointments.values.where((e)=>e.name.contains(state??"")).first;
//     if(now.isBefore(current!))
//       return ColorAppointments.StartingSoon;
//     if(now.isAfter(current!))
//       return ColorAppointments.Canceled;
//     if(now.isAtSameMomentAs(current!))
//       return  ColorAppointments.Ongoing;
//     else
//         return  ColorAppointments.Ongoing;
//   }
//   String? get getStateArabic{
//     switch(getState??ColorAppointments.Pending){
//       case ColorAppointments.Pending:
//         return "معلق";
//       case ColorAppointments.Ongoing:
//         return "قيد المعالجة";
//       case ColorAppointments.Rejected:
//         return "مرفوض";
//       case ColorAppointments.StartingSoon:
//         return "يبدأ قريبا";
//       case ColorAppointments.Concluded:
//         return "منتهي";
//       case ColorAppointments.Canceled:
//         return "ملغى";
//
//     }
//
//   }
//
//
//   Map<String, dynamic> toJson() {
//
//     return{
//       'id': id,
//     'idTool': idTool,
//     'idWorker': idWorker,
//     'nameWorker': nameWorker,
//     'idOwner': idOwner,
//     'idUser': idUser,
//     'withDelivery': withDelivery,
//     'specialInstructions': specialInstructions,
//     'state': state,
//     'nameTool': nameTool,
//     'nameCustomer': nameCustomer,
//     'deliveryAddress': deliveryAddress?.toJson(),
//       'selectDate': selectDate==null?null:Timestamp.fromDate(selectDate!),
//   };
//   }
// }
//
// ///Appointments
// class Appointments {
//   List<Appointment> items;
//
//
//
//   Appointments({required this.items});
//
//   factory Appointments.fromJson(json) {
//     List<Appointment> temp = [];
//     for (int i = 0; i < json.length; i++) {
//       Appointment tempElement = Appointment.fromJson(json[i]);
//       tempElement.id = json[i].id;
//       temp.add(tempElement);
//     }
//     return Appointments(items: temp);
//   }
//
//   Map<String, dynamic> toJson() {
//     List<Map<String, dynamic>> temp = [];
//     for (var element in items) {
//       temp.add(element.toJson());
//     }
//     return {
//       'items': temp,
//     };
//   }
// }