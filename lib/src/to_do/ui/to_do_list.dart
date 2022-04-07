import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';
import 'package:sprucetool/src/to_do/ui/to_do_page.dart';
import 'package:sprucetool/src/util/values/colors.dart';

Widget toDoListWidget(
    List<int> toDoList, double left, Controller controller, Function setState) {
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
                              todo.done = !todo.done;
                              setState();
                              controller.updateToDo(todo);
                            },
                            icon: Icon((todo.done)
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank),
                            color: AppColors.textColor,
                          ),
                          RichText(
                            text: TextSpan(
                              text: todo.name + " ",
                              children: <TextSpan>[
                                TextSpan(
                                    text: todo.description,
                                    style: TextStyle(
                                            fontWeight: FontWeight.w200)
                                        .copyWith(color: AppColors.textColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (todo.children.isNotEmpty)
                        ? toDoListWidget(
                            todo.children, left + 25, controller, setState)
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
    },
  );
}
