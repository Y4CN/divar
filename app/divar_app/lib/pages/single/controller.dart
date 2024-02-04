import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/detailItemModel.dart';
import 'package:divar_app/pages/dep_injection.dart';

abstract class ISingleController {
  Future<Either<String,DetailItemModel>> getDetailItem(int id);
}


class SingleController extends ISingleController {

  final _dio = locator.get<Dio>();
  @override
  Future<Either<String, DetailItemModel>> getDetailItem(int id) async {
    try {
 
      final response = await _dio.get("detail_item/$id");
      if (response.data["status"] == true) {

        final listItems = DetailItemModel.fromJson(response.data['item']);

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