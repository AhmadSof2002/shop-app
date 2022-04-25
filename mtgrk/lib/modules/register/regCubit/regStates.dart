import 'package:mtgrk/models/login_model/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {

  final ShopLoginModel RegisterModel;
  RegisterSuccessState(this.RegisterModel);
}

class RegisterErrorState extends RegisterStates {

  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePassVisibilityState extends RegisterStates {}
