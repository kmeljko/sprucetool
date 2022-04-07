import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprucetool/src/util/values/colors.dart';

AppBar appBar(String text, {bool withBack = false}) {
  return AppBar(
    title: Text(text),
    leading: (withBack)
        ? GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          )
        : null,
    toolbarHeight: 56,
    toolbarOpacity: 0.8,
    backgroundColor: AppColors.mainColor,
    foregroundColor: AppColors.textColor,
    titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
  );
}
