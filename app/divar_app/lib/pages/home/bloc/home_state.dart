import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/model/itemsModel.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String error;
  HomeErrorState({required this.error});
}

class HomeResponseState extends HomeState {
  List<ItemsModel> items;
  List<CategoryModel> category;
  HomeResponseState({required this.items,required this.category});
}
