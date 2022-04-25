


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/models/login_model/login_model.dart';
import 'package:mtgrk/modules/register/regCubit/regStates.dart';
import 'package:mtgrk/shared/network/remote/dio_helper.dart';
import 'package:mtgrk/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);
ShopLoginModel? RegisterModel;
  void userRegister({required String email,required String password,required String name,required String phone}){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data:{
      'phone' : phone,
      'name'  : name,
      'email' : email,
      'password' : password
    }).then((value) {
      RegisterModel= ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(RegisterSuccessState(RegisterModel!));
      
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPass= true;

  void changePassVisibility(){
      isPass = !isPass;

      suffix = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
      emit(RegisterChangePassVisibilityState()); 
  }
}