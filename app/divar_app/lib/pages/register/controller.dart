import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:divar_app/pages/dep_injection.dart';

abstract class IRegisterController {
  Future<Either<String, String>> register(
      String userName, String name, String email, String password);
}

class RegisterController extends IRegisterController {
  @override
  Future<Either<String, String>> register(
      String userName, String name, String email, String password) async {
    try {
      final _dio = locator.get<Dio>();

      FormData _formDate = FormData.fromMap({
        "user_name": userName,
        "name": name,
        "email": email,
        "password": password
      });

      final response = await _dio.post("register", data: _formDate);

      if (response.data["status"] == true) {
        return const Right("شما با موفقیت ثبت نام شدید");
      }
      return const Left("شما نمیتوانید ثبت نام کنین");
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } catch (e) {
      return const Left("خطای ناشناخته!!!!");
    }
  }
}
