import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/layout/search/states.dart';
import 'package:mtgrk/models/search_model.dart';
import 'package:mtgrk/shared/components/constants.dart';
import 'package:mtgrk/shared/network/remote/dio_helper.dart';
import 'package:mtgrk/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text' : text,
    },token: token).then((value) {
      model= SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}