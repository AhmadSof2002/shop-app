
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/layout/ShopLayout.dart';
import 'package:mtgrk/modules/login/loginScreen.dart';
import 'package:mtgrk/modules/on_borading/on_boarding_screen.dart';

import 'package:mtgrk/shared/network/local/cache_helper.dart';
import 'package:mtgrk/shared/network/remote/dio_helper.dart';
import 'package:mtgrk/shared/styles/bloc_observer.dart';
import 'package:mtgrk/shared/styles/themes.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getUserData()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) => MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget
            // onBoarding  ? LoginScreen( ) : OnBoardingScreen()
            ),
      ),
    );
  }
}
  