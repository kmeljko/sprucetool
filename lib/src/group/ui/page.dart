import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Controller controller = GetIt.I.get();
  List<String> types=["Notes", "ToDo", "Dates"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: types.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(types[index]),
          );
        },
      )),
    );
  }
}
