import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/model/userModel.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/share_manager.dart';

abstract class IProfileController {
  Future<Either<String, UserModel>> getSelfUser();
}

class ProfileController extends IProfileController {
  @override
  Future<Either<String, UserModel>> getSelfUser() async {
    try {
      final _dio = locator.get<Dio>();
      final userId = ShareManager.getUserId();

      final response = await _dio.get("/$userId");
      if (response.data["status"] == true) {
        final file = UserModel.fromJson(response.data['items']);

        return Right(file);
      }
      return const Left("خطای نگرفتن اطلاعات");
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } catch (e) {
      return const Left("خطای ناشناخته!!!!");
    }
  }
}
