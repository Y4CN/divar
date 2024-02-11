import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/search/bloc/search_event.dart';
import 'package:divar_app/pages/search/bloc/search_state.dart';
import 'package:divar_app/pages/search/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _searchController = locator.get<ISearchController>();

  SearchBloc() : super(SearchinitState()) {
    on<SearchRequestEvent>((event, emit) async {
      emit(SearchLoadingState());

      final response = await _searchController.getItemSearch(event.txt);

      response.fold((l) {
        emit(SearchErrorState(l));
      }, (r) {
        emit(SearchResponseState(r));
      });
    });
    
  }
}
