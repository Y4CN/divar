import 'package:divar_app/model/itemsModel.dart';


abstract class ArchiveState {}


class ArchiveInitState extends ArchiveState {}


class ArchiveLoadingState extends ArchiveState {}


class ArchiveErrorState extends ArchiveState {
  String err;
  ArchiveErrorState({required this.err});
}

class ArchiveResponseState extends ArchiveState {
  List<ItemsModel> items;
  ArchiveResponseState({required this.items});
}
