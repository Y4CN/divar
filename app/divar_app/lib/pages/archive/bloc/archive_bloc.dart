import 'package:divar_app/pages/archive/bloc/archive_event.dart';
import 'package:divar_app/pages/archive/bloc/archive_state.dart';
import 'package:divar_app/pages/archive/controller.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  final _archiveController = locator.get<IArchiveController>();

  ArchiveBloc() : super(ArchiveInitState()) {
    on<ArchiveRequestEvent>((event, emit) async {
      emit(ArchiveLoadingState());
      final response = await _archiveController.getItemByCategory(event.catId);

      response.fold((l) {
        emit(ArchiveErrorState(err: l));
      }, (r) {
        emit(ArchiveResponseState(items: r));
      });
    });
  }
}
