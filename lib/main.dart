// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprucetool/src/db/init.dart';
import 'package:sprucetool/src/ui/home.dart';
import 'package:sprucetool/src/util/values/colors.dart';

void main() {
  runApp(SpruceToolApp());
}

class SpruceToolApp extends StatefulWidget {
  const SpruceToolApp({Key? key}) : super(key: key);

  @override
  _SpruceToolAppState createState() => _SpruceToolAppState();
}

class _SpruceToolAppState extends State<SpruceToolApp> {
  final Future _init = Init.initialize();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spruce Tool',
      theme: ThemeData(
          primarySwatch: AppColors.createMaterialColor(),
          backgroundColor: AppColors.backgroundColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: AppColors.textColor),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: AppColors.textColor))),
          listTileTheme: ListTileThemeData(textColor: AppColors.textColor),
          textTheme: TextTheme(
            subtitle1: TextStyle(color: AppColors.textColor),
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
              bodyColor: AppColors.textColor,
              displayColor: AppColors.textColor)),
      home: FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage(
              key: UniqueKey(),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
