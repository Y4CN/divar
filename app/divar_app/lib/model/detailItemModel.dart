import 'package:divar_app/const.dart';
import 'package:divar_app/model/itemsModel.dart';

class DetailItemModel {
  int id;
  String description;
  String status;
  ItemsModel itemsModel;
  List<ImageModel> images;

  DetailItemModel({
    required this.id,
    required this.description,
    required this.status,
    required this.itemsModel,
    required this.images,
  });

  factory DetailItemModel.fromJson(Map<String, dynamic> json) {
    return DetailItemModel(
      id: json['ID'],
      description: json['description'],
      status: json['status'],
      itemsModel: ItemsModel.fromJson(json['item']),
      images: (json['Images'] as List)
          .map<ImageModel>((e) => ImageModel.fromJson(e))
          .toList(),
    );
  }
}

class ImageModel {
  int id;
  String image;

  ImageModel({
    required this.id,
    required this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["ID"],
      image: "${UrlConst.host}files/item/images/" + json['image_name'],
    );
  }
}


// {
//       "ID": 1,
//       "CreatedAt": "2024-02-04T00:41:29.823+03:30",
//       "UpdatedAt": "2024-02-04T00:41:29.823+03:30",
//       "DeletedAt": null,
//       "description": "باسلام\n⚛️فروش ویژه دوربین های مداربسته دیددرشب رنگی باگارانتی طلایی بصورت نقدوچک⚛️\n\n\n⚠️پکیج ۲عدد دوربین مداربسته شامل:\n۱عدد دستگاه ۴کانال ۵مگ فول پورت هوشمند\n۲عدد دوربین ۲مگ دید روزوشب رنگی\n۱عددهارد ۵۰۰ گیگ وسترن بنفش\n۲عدد آدابتور باکیفیت\n۲عدد جعبه ۱۰.۱۵\n۴عدد فیش bnc\n\n\n\n⚠️لطفا سیستم های برند رابادیگر سیستمهای فیک وبی کیفیت مقایسه نکنید.\n⚠️فروش بصورت نقد وچک\nبازدیدازمحل بصورت کاملا رایگان\nلطفا ازدیگر آگهی های ما بازدید فرمایید.",
//       "status": "نو",
//       "item": {
//         "ID": 1,
//         "CreatedAt": "2024-02-04T00:36:16.19+03:30",
//         "UpdatedAt": "2024-02-04T00:36:16.19+03:30",
//         "DeletedAt": null,
//         "title": "پک ۲ دوربین مداربسته دیددرشب رنگی باتجهیزات",
//         "price": "3550000",
//         "image": "c7e173d4-2ffd-4c1f-b4d6-4c7de0bab7e0.jpg",
//         "category": {
//           "ID": 1,
//           "CreatedAt": "2024-01-26T17:47:58.059+03:30",
//           "UpdatedAt": "2024-01-26T17:47:58.059+03:30",
//           "DeletedAt": null,
//           "name": "کالای دیجیتال",
//           "icon": "mobile-phone-2636.png",
//           "image": "istockphoto-479520746-612x612.jpg"
//         },
//         "user": {
//           "ID": 0,
//           "CreatedAt": "0001-01-01T00:00:00Z",
//           "UpdatedAt": "0001-01-01T00:00:00Z",
//           "DeletedAt": null,
//           "user_name": "",
//           "name": "",
//           "email": ""
//         }
//       },
//       "Images": [
//         {
//           "ID": 1,
//           "CreatedAt": "2024-02-04T00:41:29.839+03:30",
//           "UpdatedAt": "2024-02-04T00:41:29.839+03:30",
//           "DeletedAt": null,
//           "image_name": "c7e173d4-2ffd-4c1f-b4d6-4c7de0bab7e0.jpg"
//         },
//         {
//           "ID": 2,
//           "CreatedAt": "2024-02-04T00:41:29.843+03:30",
//           "UpdatedAt": "2024-02-04T00:41:29.843+03:30",
//           "DeletedAt": null,
//           "image_name": "cbc55ee9-6f4b-4121-9f75-239bd31a8f4d.jpg"
//         },
//         {
//           "ID": 3,
//           "CreatedAt": "2024-02-04T00:41:29.846+03:30",
//           "UpdatedAt": "2024-02-04T00:41:29.846+03:30",
//           "DeletedAt": null,
//           "image_name": "8bba4884-bb4f-46ed-8eea-83e3a13d49b0.jpg"
//         }
//       ]
//     }