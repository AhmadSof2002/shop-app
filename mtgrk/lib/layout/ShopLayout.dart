import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/layout/search/search_screen.dart';
import 'package:mtgrk/modules/login/loginScreen.dart';
import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Mtgark'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                  cubit.ChangeBottom(index);
                  
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label:'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
            ),
          );
        });
  }
}
