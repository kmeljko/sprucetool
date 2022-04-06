import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/utils/sembast_import_export.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/downloader/download.dart';
import 'package:sprucetool/src/ui/home.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Group name',
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                await controller.addGroup(textController.text);
                Get.to(HomePage());
              },
              child: Text('Submit'),
            ),
            IconButton(
                onPressed: () async {
                  dynamic db = await exportDatabase(controller.getDb());
                  String text = jsonEncode(db);
                  await download(utf8.encode(text),
                      "backup"+DateFormat('yyyyMMddkkmm').format(DateTime.now())+".txt");
                  Get.snackbar("Success", "",
                      snackPosition: SnackPosition.BOTTOM);
                },
                icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
