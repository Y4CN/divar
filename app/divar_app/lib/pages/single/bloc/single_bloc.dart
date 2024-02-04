import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/single/bloc/single_event.dart';
import 'package:divar_app/pages/single/bloc/single_state.dart';
import 'package:divar_app/pages/single/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleBloc extends Bloc<SingleEvent, SingleState> {
  final _singleController = locator.get<ISingleController>();

  SingleBloc() : super(SingleInitState()) {
    on<SingleRequestEvent>((event, emit) async {
      emit(SingleLoadingState());
      final response = await _singleController.getDetailItem(event.itemId);

      response.fold((l) {
        emit(SingleErrorState(err: l));
      }, (r) {
        emit(SingleResponseState(detailItemModel: r));
      });
    });
  }
}
