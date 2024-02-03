import 'package:divar_app/pages/Register/bloc/Register_event.dart';
import 'package:divar_app/pages/Register/bloc/Register_state.dart';
import 'package:divar_app/pages/Register/controller.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerController = locator.get<IRegisterController>();

  RegisterBloc() : super(RegisterInitState()) {
    on<RegisterRequestEvent>((event, emit) async {
      emit(RegisterLoadingState());
      var res = await _registerController.register(
          event.userName, event.name, event.emal, event.pass);
      res.fold((l) {
        emit(RegisterErrorState(l));
      }, (r) {
        emit(RegisterResponseState(r));
      });
    });
  }
}
