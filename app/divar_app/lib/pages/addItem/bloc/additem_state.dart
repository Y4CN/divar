import 'package:divar_app/model/categoryModel.dart';

abstract class AddItemState{}


class AddIteminitState extends AddItemState{}
class AddItemLoadingGetCategoryState extends AddItemState{}
class AddItemErrorGetCategoryState extends AddItemState{
  String err;
  AddItemErrorGetCategoryState(this.err);
}
class AddItemResponseGetCategoryState extends AddItemState{
  List<CategoryModel> category;

  AddItemResponseGetCategoryState(this.category);
}


class AddItemLoadingSumbitState extends AddItemState{}
class AddItemErrorSumbitState extends AddItemState{
  String err;
  AddItemErrorSumbitState(this.err);
}


class AddItemResponseSubmitState extends AddItemState{
  String response;

  AddItemResponseSubmitState(this.response);
}
