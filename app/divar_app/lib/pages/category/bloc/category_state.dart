import 'package:divar_app/model/categoryModel.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  List<CategoryModel> categories;
  CategoryResponseState({required this.categories});
}

class CategoryErrorState extends CategoryState {
  String err;
  CategoryErrorState({required this.err});
}
