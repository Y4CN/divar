
import 'package:divar_app/pages/addItem/bloc/additem_event.dart';
import 'package:divar_app/pages/addItem/bloc/additem_state.dart';
import 'package:divar_app/pages/addItem/controller.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final _controller = locator.get<IAddItemController>();

  AddItemBloc() : super(AddIteminitState()) {
    on<AddItemGetCategoryEvent>((event, emit) async {
      emit(AddItemLoadingGetCategoryState());
      final response = await _controller.getCategories();

      response.fold((l) {
        emit(AddItemErrorGetCategoryState(l));
      }, (r) {
        emit(AddItemResponseGetCategoryState(r));
      });
    });

    on<AddItemRequestAddEvent>((event, emit) async {
      emit(AddItemLoadingSumbitState());

      final response = await _controller.addItem(event.categoryId, event.images,
          event.title, event.price, event.description, event.status);

      response.fold((l) {
        emit(AddItemErrorSumbitState(l));
      }, (r) {
        emit(AddItemResponseSubmitState(r));
      });
    });
  }
}
