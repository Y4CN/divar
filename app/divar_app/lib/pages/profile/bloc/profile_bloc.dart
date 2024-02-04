import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/profile/bloc/profile_event.dart';
import 'package:divar_app/pages/profile/bloc/profile_state.dart';
import 'package:divar_app/pages/profile/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileRequestEvent, ProfileState> {
  final _controller = locator.get<IProfileController>();

  ProfileBloc() : super(ProfileInitState()) {
    on<ProfileRequestEvent>((event, emit) async {
      emit(ProfileLoadingState());
      final res = await _controller.getSelfUser();

      res.fold((l) {
        emit(ProfileErrorState(l));
      }, (r) {
        emit(ProfileResponseState(r));
      });
      
    });
  }
}
