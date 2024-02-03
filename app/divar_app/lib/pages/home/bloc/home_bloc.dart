import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/home/bloc/home_event.dart';
import 'package:divar_app/pages/home/bloc/home_state.dart';
import 'package:divar_app/pages/home/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _homeController = locator.get<IHomeController>();

  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestAllDataEvent>((event, emit) async {
      emit(HomeLoadingState());

      final response = await _homeController.getAllItem();
        final categoryItems = await _homeController.getCategoryItem();
      response.fold((l) {
        emit(HomeErrorState(error: l));
      }, (item) async {
        categoryItems.fold((l) {
          emit(HomeErrorState(error: l));
        }, (r) {
          emit(HomeResponseState(items: item, category: r));
        });
      });
    });
  }
}
