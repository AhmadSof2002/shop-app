import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/models/login_model/login_model.dart';
import 'package:mtgrk/modules/login/cubit/states.dart';
import 'package:mtgrk/shared/cubit/states.dart';
import 'package:mtgrk/shared/network/remote/dio_helper.dart';
import 'package:mtgrk/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=> BlocProvider.of(context);
ShopLoginModel? loginModel;
  void userLogin({required String email,required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data:{
      'email' : email,
      'password' : password
    }).then((value) {
      loginModel= ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(LoginSuccessState(loginModel!));
      
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPass= true;

  void changePassVisibility(){
      isPass = !isPass;

      suffix = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
      emit(LoginChangePassVisibilityState()); 
  }
}