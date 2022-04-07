import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/to_do/ui/add.dart';
import 'package:sprucetool/src/to_do/ui/to_do_list.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/util/values/colors.dart';

class GroupToDoList extends StatefulWidget {
  const GroupToDoList({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupToDoListState createState() => _GroupToDoListState();
}

class _GroupToDoListState extends State<GroupToDoList> {
  Controller controller = GetIt.I.get();

  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.group.name + " - To Do", withBack: true),
      body: SizedBox.expand(
        child: SingleChildScrollView(
            child: toDoListWidget(widget.group.toDoList, 0, controller, refresh)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(ToDoAdd(group: widget.group));
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
