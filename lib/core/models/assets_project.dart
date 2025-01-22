
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file_model.dart';

class AssetsProject {
  String? id;
  String? idUser;
  String? name;
  String? quantity;
  num? price;
  num? total;
  String? url;
  String? localUrl;
  DateTime? dateTime;

  AssetsProject({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.total,
    this.url,
    this.localUrl,
    this.dateTime,
    this.idUser,
  });

  factory AssetsProject.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    return AssetsProject(
        id: data['id'],
      idUser: data["idUser"],
      dateTime: data["dateTime"]?.toDate(),
      name: data["name"],
      quantity: data["quantity"],
      url: data["url"],
      localUrl: data["localUrl"],
      price: num.tryParse( "${data["price"]}"),
      total: num.tryParse("${data["total"]}" ),
    );
  }

  factory AssetsProject.init() {
    return AssetsProject();
  }


  Map<String, dynamic> toJson() {
    return{
      'id': id,
    'name': name,
    'quantity': quantity,
    'localUrl': localUrl,
    'url': url,
    'total': total,
    'price': price,
    'idUser': idUser,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
  };
  }
}

///AssetsProjects
class AssetsProjects {
  List<AssetsProject> items;



  AssetsProjects({required this.items});

  factory AssetsProjects.fromJson(json) {
    List<AssetsProject> temp = [];
    for (int i = 0; i < json.length; i++) {
      AssetsProject tempElement = AssetsProject.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return AssetsProjects(items: temp);
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