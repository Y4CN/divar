import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/itemsModel.dart';
import 'package:divar_app/pages/dep_injection.dart';

abstract class ISearchController {
  Future<Either<String, List<ItemsModel>>> getItemSearch(String txt);
}

class SearchController extends ISearchController {
  final _dio = locator.get<Dio>();
  @override
  Future<Either<String, List<ItemsModel>>> getItemSearch(String txt) async {
    try {
      final response = await _dio.get("items/search", queryParameters: {
        "txt": txt,
      });
      if (response.data["status"] == true) {
        final listItems = response.data['item']
            .map<ItemsModel>((e) => ItemsModel.fromJson(e))
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
