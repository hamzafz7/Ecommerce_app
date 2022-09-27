import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/ecommerce_app/models/searchmodel/search_model.dart';
import 'package:ecommerce_app/ecommerce_app/modules/search/cubit/search_states.dart';
import 'package:ecommerce_app/network/remote/DioHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());
  SearchModel? model;

  void Search(String text) async {
    emit(SearchLoadingState());
    SharedPreferences sh = await SharedPreferences.getInstance();
    DioHelper.postdata(
        url: "products/search",
        query: null,
        token: sh.getString('token'),
        data: {'text': text}).then((value) {
      model = SearchModel.fromJson(value.data);
      print(model!.status);
      emit(SearchSuccessState());
    }).catchError((e) {
      emit(SearchErrorState());
    });
  }
}
