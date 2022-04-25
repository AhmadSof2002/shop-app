import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mtgrk/shared/styles/colors.dart';

ThemeData darkTheme=  ThemeData(
              scaffoldBackgroundColor: HexColor('121212'),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  backwardsCompatibility: false,
                  backgroundColor: HexColor('121212'),
                  elevation: 0.0,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: HexColor('121212')),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              primarySwatch: defaultColor,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('121212'),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: defaultColor,
                  elevation: 20.0),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600)),
                      fontFamily: 'Jannah'
            );
ThemeData lightTheme= ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backwardsCompatibility: false,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.white),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              primarySwatch: defaultColor,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: defaultColor,
                  elevation: 20.0,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600)),
                      fontFamily: 'Jannah'
            );          