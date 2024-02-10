import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/share_manager.dart';

abstract class IAddItemController {
  Future<Either<String, String>> addItem(int categoryId, List<File> images,
      String title, String price, String description, String status);
  Future<Either<String, List<CategoryModel>>> getCategories();
}

class AddItemController extends IAddItemController {
  final _dio = locator.get<Dio>();
  @override
  Future<Either<String, String>> addItem(int categoryId, List<File> images,
      String title, String price, String description, String status) async {
    try {
      FormData _formData = FormData.fromMap({
        "title": title,
        "price": price,
        "image":await MultipartFile.fromFile(images[0].path),
      });

      final _userId = ShareManager.getUserId();


      final response = await _dio.post(
        "items/create/$categoryId/$_userId",
        data: _formData,
      );
      if (response.data["status"] == true) {
        FormData _formDataDetail = FormData.fromMap({
          "description": description,
          "status": status,
        });
        for (var i = 0; i < images.length; i++) {
          _formDataDetail.files.add(
            MapEntry(
              'images',
              await MultipartFile.fromFile(images[i].path),
            ),
          );
        }

        var responseDetail = await _dio
            .post("detail_item/create/${response.data["item"]["ID"]}",data: _formDataDetail);
        if (responseDetail.data["status"] == true) {
          return const Right("تبلیغ شما اضافه شد");
        } else {
          return const Left("خطای اضافه کردن جزئیات تبلیغ");
        }
      } else {
        return const Left("خطای اضافه کردن تبلیغ");
      }
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } catch (e) {
      return const Left("خطای ناشناخته!!!!");
    }
  }

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _dio.get("category/");
      if (response.data["status"] == true) {
        final listItems = response.data['item']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();

        return Right(listItems);
      }
      return const Left("خطای نگرفتن اطلاعات");
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } catch (e) {
      return const Left("خطای ناشناخته!!!!");
    }
  }
}
