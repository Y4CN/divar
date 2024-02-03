import 'package:dartz/dartz.dart';
import 'package:divar_app/model/categoryModel.dart';

abstract class IHomeController{
 Future<Either<String, List<CategoryModel>>> getCategoryItem();
//  Future<Either<String, List<ItemsModel>>> getAllItem();
} 






