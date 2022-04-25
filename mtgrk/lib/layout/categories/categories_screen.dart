import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/models/categories_model.dart';
import 'package:mtgrk/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition:ShopCubit.get(context).categoriesModel !=null ,
                fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context)=> ListView.separated(
                itemBuilder: (context, index) => 
                   buildCategoryItem(
                      ShopCubit.get(context).categoriesModel!.data!.data![index]),
                
                   
              
                separatorBuilder: (context, index) => myDivider(),
                itemCount:  ShopCubit.get(context).categoriesModel!.data!.data!.length),
          );
        });
  }

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(image: CachedNetworkImageProvider(model.image!,maxHeight: 120,maxWidth: 120)),

            // Image(
            //   image: NetworkImage(model.image!),
            //   height: 120,
            //   width: 120,
            // ),
            SizedBox(width: 20.0),
            Text(
              model.name!,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
