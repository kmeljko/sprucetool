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

  Widget toDoWidget(List<int> toDoList, double left) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: controller.getToDo(toDoList[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ToDo todo = snapshot.data as ToDo;
              return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 8, bottom: 8, left: 8 + left),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    todo.done = !todo.done;
                                  });
                                  controller.updateToDo(todo);
                                },
                                icon: Icon((todo.done)
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank)),
                            RichText(
                              text: TextSpan(
                                text: todo.name + " ",
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: todo.description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      (todo.children.isNotEmpty)
                          ? toDoWidget(todo.children, left + 25)
                          : Container()
                    ],
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
      body: SingleChildScrollView(child: toDoWidget(widget.group.toDoList, 0)),
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
