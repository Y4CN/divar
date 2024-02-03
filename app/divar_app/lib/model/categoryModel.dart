import 'package:divar_app/const.dart';

class CategoryModel {
  int id;
  String name;
  String icon;
  String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['ID'],
      name:json['name'],
      icon: "${UrlConst.host}files/category/" + json['icon'],
      image:  "${UrlConst.host}files/category/" + json['image'],
    );
  }
}
