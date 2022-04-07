import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/group/ui/notes.dart';
import 'package:sprucetool/src/group/ui/to_do_list.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Controller controller = GetIt.I.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.group.name, withBack: true),
      body: Center(
          child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(GroupNotes(group: widget.group));
            },
            child: ListTile(
              title: Text("Notes"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(GroupToDoList(group: widget.group));
            },
            child: ListTile(
              title: Text("To do"),
            ),
          ),
          ListTile(
            title: Text("Dates - not implemented"),
          )
        ],
      )),
    );
  }
}
