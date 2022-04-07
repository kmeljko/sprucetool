import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';
import 'package:sprucetool/src/to_do/ui/add.dart';
import 'package:sprucetool/src/to_do/ui/to_do_page.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

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

  Widget toDoWidget(List<int> toDoList) {
    return ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: controller.getToDo(toDoList[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ToDo todo = snapshot.data as ToDo;
              return GestureDetector(
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        text: todo.name+" ",
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: todo.description,
                              style: TextStyle(fontWeight: FontWeight.w200)),
                        ],
                      ),
                    ),
                    subtitle: (todo.children.isNotEmpty)
                        ? toDoWidget(todo.children)
                        : null,
                  ),
                  onTap: () {
                    Get.to(ToDoPage(todo: todo));
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.group.name + " - To Do", withBack: true),
      body: Center(child: toDoWidget(widget.group.toDoList)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ToDoAdd(group: widget.group));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
