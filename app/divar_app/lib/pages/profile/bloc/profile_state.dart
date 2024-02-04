import 'package:divar_app/model/userModel.dart';

abstract class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  String err;

  ProfileErrorState(this.err);
}

class ProfileResponseState extends ProfileState {
  UserModel userModel;

  ProfileResponseState(this.userModel);
}
