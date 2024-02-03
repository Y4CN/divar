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

    // {
    //   "ID": 1,
    //   "CreatedAt": "2024-01-26T17:47:58.059+03:30",
    //   "UpdatedAt": "2024-01-26T17:47:58.059+03:30",
    //   "DeletedAt": null,
    //   "name": "کالای دیجیتال",
    //   "icon": "mobile-phone-2636.png",
    //   "image": "istockphoto-479520746-612x612.jpg"
    // },
