import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/share_manager.dart';

abstract class ILoginController {
  Future<Either<String, String>> login(String email, String password);
}

class LoginController extends ILoginController {
  @override
  Future<Either<String, String>> login(String email, String password) async {
    try {
      final _dio = locator.get<Dio>();
      FormData _formDate =
          FormData.fromMap({"email": email, "password": password});
      final response = await _dio.post("login", data: _formDate);
      if (response.data["status"] == true) {
        ShareManager.setUserId(response.data['items']["ID"]);
        ShareManager.setUserToken(response.data['token']);
        return const Right("شما با موفقیت وارد شدید");
      }
      return const Left("شما نمیتوانید وارد شوید");

    } on DioException catch (e) {
      
      return Left(e.response!.data['message']);
    } catch (e) {
      
      return const Left("خطای ناشناخته!!!!");
    }
  }
}
