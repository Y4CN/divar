import 'package:divar_app/model/detailItemModel.dart';

abstract class SingleState {}

class SingleInitState extends SingleState {}

class SingleLoadingState extends SingleState {}

class SingleErrorState extends SingleState {
  String err;
  SingleErrorState({required this.err});
}

class SingleResponseState extends SingleState {
  DetailItemModel detailItemModel;

  SingleResponseState({
    required this.detailItemModel,
  });
}
