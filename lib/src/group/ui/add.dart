import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sembast/utils/sembast_import_export.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/ui/home.dart';
import 'package:sprucetool/src/util/downloader/download.dart';
import 'package:sprucetool/src/util/values/colors.dart';

class GroupAdd extends StatefulWidget {
  const GroupAdd({Key? key}) : super(key: key);

  @override
  _GroupAddState createState() => _GroupAddState();
}

class _GroupAddState extends State<GroupAdd> {
  Controller controller = GetIt.I.get();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Add group", withBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  
                  labelText: 'Group name',
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(AppColors.textColor),
                ),
                onPressed: () async {
                  await controller.addGroup(textController.text);
                  Get.offAll(
                    HomePage(
                      key: UniqueKey(),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
              IconButton(
                  onPressed: () async {
                    dynamic db = await exportDatabase(controller.getDb());
                    String text = jsonEncode(db);
                    // ignore: avoid_print
                    print(text);
                    await download(
                        utf8.encode(text),
                        "backup" +
                            DateFormat('yyyyMMddkkmm').format(DateTime.now()) +
                            ".txt");
                    Get.snackbar("Success", "",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  icon: Icon(Icons.settings, color: AppColors.textColor,)),
            ],
          ),
        ),
      ),
    );
  }
}
