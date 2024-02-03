import 'package:divar_app/pages/category/bloc/category_event.dart';
import 'package:divar_app/pages/category/bloc/category_state.dart';
import 'package:divar_app/pages/category/controller.dart';
import 'package:divar_app/pages/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{

final _categoryController =locator.get<ICategoryController>();

  CategoryBloc():super(CategoryInitState()){
    on<CategoryRequestGetItemEvent>((event, emit) async {
      emit(CategoryLoadingState());
      final response = await _categoryController.getCategoryItem();

      response.fold((l) {
        emit(CategoryErrorState(err: l));
      }, (r) {
        emit(CategoryResponseState(categories: r));
      });
    });
  }
}