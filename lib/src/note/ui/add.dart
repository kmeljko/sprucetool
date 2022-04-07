import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sembast/utils/sembast_import_export.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/ui/home.dart';
import 'package:sprucetool/src/util/downloader/download.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({Key? key, required this.group}) : super(key: key);

  final Group group;
  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  Controller controller = GetIt.I.get();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Add note", withBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note name',
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {
                  await controller.addNote(widget.group, textController.text);
                  Get.offAll(
                    HomePage(
                      key: UniqueKey(),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
