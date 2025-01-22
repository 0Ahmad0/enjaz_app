//
// import 'package:tools_to_go_app/core/models/review_model.dart';
//
// class ToolModel {
//   String? id;
//   String? name;
//   String? description;
//   String? specifications;
//   String? photoUrl;
//   List<String>? images;
//   num? fee;
//   List<ReviewModel>? reviews;
//
//   ToolModel({
//     this.id,
//     this.name,
//     this.description,
//     this.specifications,
//     this.photoUrl,
//     this.fee,
//     this.images=const [],
//     this.reviews,
//   });
//   double get  getRate{
//     double rate=0;
//     if(reviews?.isEmpty??true)
//       return 0;
//     for(ReviewModel review in reviews??[]){
//       rate+=review.avgRate;
//     }
//     return rate/(reviews?.length??1);
//   }
//
//   factory ToolModel.fromJson(json) {
//     var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
//     List<String> tempList = [];
//     for(var element in data["images"]){
//       tempList.add("${element}");
//     }
//
//     List<ReviewModel> tempListReviews = [];
//
//     for(var review in data["reviews"]??[]){
//       tempListReviews.add(ReviewModel.fromJson(review));
//     }
//
//     return ToolModel(
//         id: data['id'],
//       name: data["name"],
//       description: data["description"],
//       photoUrl: data["photoUrl"],
//       specifications: data["specifications"],
//       fee: num.tryParse("${data["fee"]}"),
//       images: tempList,
//       reviews: tempListReviews
//
//     );
//   }
//
//   factory ToolModel.init() {
//     return ToolModel();
//   }
//
//   Map<String, dynamic> toJson() {
//
//     List<Map<String, dynamic>> tempListReviews = [];
//     for(ReviewModel review in reviews??[]){
//       tempListReviews.add(review.toJson());
//     }
//     return{
//       'id': id,
//     'name': name,
//     'description': description,
//     'specifications': specifications,
//     'photoUrl': photoUrl,
//     'images': images,
//     'fee': fee,
//       'reviews':tempListReviews
//   };
//   }
// }
//
// ///Tools
// class Tools {
//   List<ToolModel> items;
//
//
//
//   Tools({required this.items});
//
//   factory Tools.fromJson(json) {
//     List<ToolModel> temp = [];
//     for (int i = 0; i < json.length; i++) {
//       ToolModel tempElement = ToolModel.fromJson(json[i]);
//       tempElement.id = json[i].id;
//       temp.add(tempElement);
//     }
//     return Tools(items: temp);
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