import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/models/favorites_model.dart';
import 'package:mtgrk/models/home_model.dart';
import 'package:mtgrk/models/search_model.dart';
import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
                var userFavs = ShopCubit.get(context).favoritesModel?.data?.data;
           
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState && userFavs !=null&& ShopCubit.get(context).favorites.isNotEmpty ,
          builder: (context) {
              return ListView.separated(
              itemBuilder: (context, index) {
                
               return  buildListProduct(
                        ShopCubit.get(context).favoritesModel!.data!.data![index].product,context);
              
              } ,
              separatorBuilder: (context, index) => myDivider(),
              itemCount:   ShopCubit.get(context).favoritesModel!.data!.data!.length);
          }, 
              fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

}
