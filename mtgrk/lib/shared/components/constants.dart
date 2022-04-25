import 'package:flutter/cupertino.dart';
import 'package:mtgrk/modules/login/loginScreen.dart';
import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/network/local/cache_helper.dart';

void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token')
      .then((value) => navigateAndFinish(context, LoginScreen()));
}

void printFullText(String? text){
  final pattern= RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

String? token='';