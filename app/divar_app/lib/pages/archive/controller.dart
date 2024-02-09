import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/itemsModel.dart';
import 'package:divar_app/pages/dep_injection.dart';

abstract class IArchiveController{
  Future<Either<String,List<ItemsModel>>> getItemByCategory(int catId);
}


class ArchiveController extends IArchiveController{
  @override
  Future<Either<String, List<ItemsModel>>> getItemByCategory(int catId) async {
     try {
      final _dio = locator.get<Dio>();

      final response = await _dio.get("items/$catId");
      if (response.data["status"] == true) {
        final listItems = response.data['item']
            .map<ItemsModel>((e) => ItemsModel.fromJson(e))
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