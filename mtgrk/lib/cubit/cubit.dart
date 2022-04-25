import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/layout/categories/categories_screen.dart';
import 'package:mtgrk/layout/favourites/favourites_screen.dart';
import 'package:mtgrk/layout/products/products_screen.dart';
import 'package:mtgrk/layout/settings/settings_screen.dart';
import 'package:mtgrk/models/categories_model.dart';
import 'package:mtgrk/models/change_favorites_model.dart';
import 'package:mtgrk/models/favorites_model.dart';
import 'package:mtgrk/models/home_model.dart';
import 'package:mtgrk/models/login_model/login_model.dart';
import 'package:mtgrk/shared/components/constants.dart';
import 'package:mtgrk/shared/network/remote/dio_helper.dart';
import 'package:mtgrk/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    FavouritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      printFullText(homeModel!.data!.banners[0].image);
      emit(ShopSucessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSucessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavsState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSucessChangeFavsState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ShopErrorChangeFavsState());
    });
  }
    FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSucessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUserState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSucessGetUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserState());
    });
  }



  void updateUserData({
    required String name,
    required String email,
    required String phone,

  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token,data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
    
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSucessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}
