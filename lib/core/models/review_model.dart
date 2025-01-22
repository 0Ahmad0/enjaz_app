import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  String? idUser;
  double? review;
  String? text;

  ReviewModel(
      {
        this.id,
        this.idUser,
        this.review,
        this.text,
      });

  double get avgRate{
    int countReview=0;
    double sumReview=0;
    if(review!=null){
      countReview++;
      sumReview+=review!;
    }
    countReview=countReview==0?1:countReview;
    return sumReview/countReview;

  }
  factory ReviewModel.fromJson( json){
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;

    return ReviewModel(
      idUser: data["idUser"],
      review: data["review"],
      text: data["text"],
    );
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'review': review,
      'text': text,
    };
  }
  factory ReviewModel.init(){
    return ReviewModel();
  }
}