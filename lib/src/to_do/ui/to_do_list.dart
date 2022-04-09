import 'package:flutter/material.dart';

import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';
import 'package:sprucetool/src/to_do/ui/to_do_page.dart';
import 'package:sprucetool/src/util/values/colors.dart';

Widget toDoListWidget(
    List<int> toDoList, double left, Controller controller, Function setState,
    {bool showItems = true}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: toDoList.length,
    itemBuilder: (context, index) {
      return ToDoList(
        id: toDoList[index],
        left: left + 25,
        controller: controller,
        setState: setState,
        showItems: showItems,
      );
    },
  );
}

class ToDoList extends StatefulWidget {
  final int id;
  final double left;
  final Controller controller;
  final Function setState;
  final bool showItems;
  const ToDoList({
    Key? key,
    required this.id,
    required this.left,
    required this.controller,
    required this.setState,
    required this.showItems,
  }) : super(key: key);
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late final Future? myFuture = widget.controller.getToDo(widget.id);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ToDo todo = snapshot.data as ToDo;
          return GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8, left: 8 + widget.left),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            todo.done = !todo.done;
                            widget.setState();
                            widget.controller.updateToDo(todo);
                          },
                          icon: Icon((todo.done)
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank),
                          color: AppColors.textColor,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: RichText(
                              text: TextSpan(
                                text: todo.name + " ",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: todo.description,
                                      style:
                                          TextStyle(fontWeight: FontWeight.w200)
                                              .copyWith(
                                                  color: AppColors.textColor)),
                                  (widget.showItems || todo.children.isEmpty)
                                      ? TextSpan()
                                      : TextSpan(
                                          text: todo.children.length.toString(),
                                          style: TextStyle(
                                                  fontWeight: FontWeight.w200)
                                              .copyWith(
                                                  color: AppColors.textColor)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (todo.children.isNotEmpty && widget.showItems)
                      ? toDoListWidget(todo.children, widget.left + 25,
                          widget.controller, setState)
                      : Container()
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToDoPage(
                            todo: todo,
                            key: UniqueKey(),
                          )),
                );
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
