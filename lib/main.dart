// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprucetool/src/db/init.dart';
import 'package:sprucetool/src/ui/home.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage(
              key: UniqueKey(),
            );
          } else {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
