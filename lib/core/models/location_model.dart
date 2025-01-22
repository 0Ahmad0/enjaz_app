import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  String? id;
  String? address;
  double? latitude;
  double? longitude;
  DateTime? dateTime;

  LocationModel(
      {
        this.id,
         this.address,
        this.latitude,
        this.longitude,
        this.dateTime,
      });
  factory LocationModel.fromJson( json){
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;

    return LocationModel(
      address: data["address"],
      latitude: double.tryParse("${json["Latitude"]}"),
      longitude: double.tryParse("${json["Longitude"]}"),
      dateTime: data["timestamp"]?.toDate(),

    );
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'Latitude': latitude,
      'Longitude': longitude,
      'address': address,
      'timestamp': dateTime==null?null:Timestamp.fromDate(dateTime!),
    };
  }
  factory LocationModel.init(){
    return LocationModel();
  }
}
//Files
class Files {
  List<LocationModel> items;



  Files({required this.items});

  factory Files.fromJson(json) {
    List<LocationModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      LocationModel tempElement = LocationModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Files(items: temp);
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