import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/shared/cubit/cubit.dart';
import 'package:mtgrk/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  double radius = 10,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 55,
      width: width,
      child: MaterialButton(
        elevation: 5,
        onPressed: function,
        color: color,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    );

Widget defaultTextButton(
        {required VoidCallback function,
        required String text,
        TextStyle? textStyle}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: textStyle,
        ));

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onChanged,
        VoidCallback? onTap,
        required String label,
        required IconData prefix,
        required String? Function(String?)? validator,
        bool isPassword = false,
        bool Cursor = true,
        bool readOnly = false,
        VoidCallback? suffixPressed,
        Function(String)? onSubmit,
        IconData? suffix}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.grey,
          focusColor: Colors.grey,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
              : null),
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      showCursor: Cursor,
      readOnly: readOnly,
    );

Widget buildTaskItem(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${model['title']} ',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text('${model['date']}', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                ))
          ],
        ),
      ),
    );

Widget taskBuilder({required List<Map> tasks}) => ConditionalBuilder(
      builder: (BuildContext context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[200],
              ),
          itemCount: tasks.length),
      condition: tasks.length > 0,
      fallback: (BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          ],
        ),
      ),
    );

Widget buildArticleItem(article, context) => Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: article['urlToImage'] == null
                        ? CachedNetworkImageProvider(
                            'https://4.bp.blogspot.com/-OCutvC4wPps/XfNnRz5PvhI/AAAAAAAAEfo/qJ8P1sqLWesMdOSiEoUH85s3hs_vn97HACLcBGAsYHQ/s1600/no-image-found-360x260.png')
                        : CachedNetworkImageProvider(
                            '${article['urlToImage']}'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget myDivider() {
  return Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[200],
  );
}

void toastMessage({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget articleBuilder(list) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()));

void navigateTo(BuildContext context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget buildListProduct(model, BuildContext context, {bool isSearch = true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                  height: 120,
                  width: 120,
                  child:
                      Image(image: CachedNetworkImageProvider(model!.image!))),

              // Image(
              //   image: NetworkImage(model.image!),
              //   width: double.infinity,
              //   height: 200.0,
              // ),
              if (model.discount != 0 && isSearch == false)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                  color: Colors.red[900],
                )
            ],
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.0, height: 1.3, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      // '${model.price.round()}'
                      '${model.price.round().toString()}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: defaultColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && isSearch == false)
                      Text(
                        // '${model.oldPrice.round()}'
                        '${model.oldPrice.round().toString()}',
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
