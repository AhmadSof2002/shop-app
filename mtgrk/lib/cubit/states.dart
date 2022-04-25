import 'package:mtgrk/models/change_favorites_model.dart';
import 'package:mtgrk/models/login_model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}

class ShopSucessHomeState extends ShopStates{}

class ShopErrorHomeState extends ShopStates{}

class ShopSucessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavsState extends ShopStates{}

class ShopSucessChangeFavsState extends ShopStates{

 final ChangeFavoritesModel model;
  ShopSucessChangeFavsState(this.model);

}

class ShopErrorChangeFavsState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSucessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingGetUserState extends ShopStates{}

class ShopSucessGetUserState extends ShopStates{
  final ShopLoginModel userModel;

  ShopSucessGetUserState(this.userModel);
}

class ShopErrorGetUserState extends ShopStates{}


class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSucessUpdateUserState extends ShopStates{
  final ShopLoginModel userModel;

  ShopSucessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates{}