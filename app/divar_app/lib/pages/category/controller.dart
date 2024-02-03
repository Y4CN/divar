import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/pages/dep_injection.dart';

abstract class ICategoryController {
  Future<Either<String, List<CategoryModel>>> getCategoryItem();
}

class CategoryController extends ICategoryController {
  @override
  Future<Either<String, List<CategoryModel>>> getCategoryItem() async {
    try {
      final _dio = locator.get<Dio>();

      final response = await _dio.get("category/");
      if (response.data["status"] == true) {
        final listItems = response.data['item']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();

        return  Right(listItems);
      }
      return const Left("خطای نگرفتن اطلاعات");
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } catch (e) {
      return const Left("خطای ناشناخته!!!!");
    }
  }
}
