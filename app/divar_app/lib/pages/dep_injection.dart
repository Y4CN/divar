import 'package:dio/dio.dart';
import 'package:divar_app/const.dart';
import 'package:divar_app/pages/Register/controller.dart';
import 'package:divar_app/pages/category/controller.dart';
import 'package:divar_app/pages/home/controller.dart';
import 'package:divar_app/pages/login/controller.dart';
import 'package:divar_app/pages/single/controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> initGetIt() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl:UrlConst.host),
    ),
  );

  //? controllers
  locator.registerSingleton<ILoginController>(LoginController());
  locator.registerSingleton<IRegisterController>(RegisterController());
  locator.registerSingleton<ICategoryController>(CategoryController());
  locator.registerSingleton<IHomeController>(HomeController());
  locator.registerSingleton<ISingleController>(SingleController());
}


