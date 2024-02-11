import 'package:divar_app/model/itemsModel.dart';

abstract class SearchState{}


class SearchinitState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchErrorState extends SearchState{
  String err;

  SearchErrorState(this.err);
}
class SearchResponseState extends SearchState{
  List<ItemsModel> items;

  SearchResponseState(this.items);
}