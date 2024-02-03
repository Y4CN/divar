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
      name: json['name'],
      icon: json['icon'],
      image: json['image'],
    );
  }
}