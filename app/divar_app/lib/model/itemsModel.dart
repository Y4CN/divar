import 'package:divar_app/const.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/model/userModel.dart';

class ItemsModel {
  int id;
  String title;
  String price;
  String image;
  String createdAt;
  CategoryModel categoryModel;
  UserModel userModel;

  ItemsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.categoryModel,
    required this.userModel,
    required this.createdAt,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      id: json['ID'],
      title: json['title'],
      price: json['price'],
      image: "${UrlConst.host}files/items/" + json['image'],
      categoryModel: CategoryModel.fromJson(json['category']),
      userModel: UserModel.fromJson(json['user']),
      createdAt: json['CreatedAt']
    );
  }
}
