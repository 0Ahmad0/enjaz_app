import 'package:cloud_firestore/cloud_firestore.dart';

class FileModel {
  String id;
  String? name;
  int? size;
  String? url;
  // String urlTempPhoto;
  String? localUrl;
  String? type;
  String? subType;

  FileModel(
      {
        this.id="",
         this.name,
        this.url="",
        this.localUrl="",
        this.size=0,
        this.type,
        this.subType,


      });
  factory FileModel.fromJson( json){
    return FileModel(
      url: json["url"],
      localUrl: json["localUrl"],
      name: json["name"],
      type: json["type"],
      size: json["size"],
      subType: json["subType"],

    );
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'type': type,

      'url': url,
      'localUrl': localUrl,
      'subType': subType,
    };
  }
  factory FileModel.init(){
    return FileModel();
  }
}
//Files
class Files {
  List<FileModel> items;



  Files({required this.items});

  factory Files.fromJson(json) {
    List<FileModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      FileModel tempElement = FileModel.fromJson(json[i]);
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