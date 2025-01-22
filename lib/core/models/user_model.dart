
import 'package:bcrypt/bcrypt.dart';

import '../utils/app_constant.dart';

class UserModel {
  String? id;
  String? uid;
  String? name;
  String? userName;
  String? photoUrl;
  String? phoneNumber;
  String? email;
  String? password;
  String? typeUser;
  String? gender;
  String? state;
  bool isAdd = false;

  bool get isAdmin=>typeUser?.toLowerCase().contains(AppConstants.collectionAdmin.toLowerCase())??false;
  // bool get isOwner=>typeUser?.toLowerCase().contains(AppConstants.collectionOwner.toLowerCase())??false;
  // bool get isWorker=>typeUser?.toLowerCase().contains(AppConstants.collectionWorker.toLowerCase())??false;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.password,
    this.typeUser,
    this.gender,
    this.state,
  });

  factory UserModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    String name =
        json["name"] ?? '${json["firstName"] ?? ''} ${json["lastName"] ?? ''}';
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: json["name"],
      // phoneNumber: json["phoneNumber"],
      // userName: json["userName"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      typeUser: json["typeUser"],
      // gender: data["gender"],
       password:data['password'],
        // state:data['state']
    );
  }

  factory UserModel.init() {
    return UserModel(
      id: "",
      uid: '',
      name: '',
      email: '',
      typeUser: '',
    //  password: ''
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        // 'userName': userName,
        // 'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'typeUser': typeUser,
        // 'gender': gender,
    'password': password==null?null:BCrypt.hashpw(password!, BCrypt.gensalt()),
    // 'state':state,
    // 'password': password,
      };
  /// Function to check if the password matches the hashed password
  bool checkPassword(String plainPassword) {
    return BCrypt.checkpw(plainPassword, password??'');
  }
}

//users
class Users {
  List<UserModel> items;

  //DateTime date;

  Users({required this.items});

  factory Users.fromJson(json) {
    List<UserModel> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      UserModel tempUser = UserModel.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(items: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (UserModel user in items) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}
