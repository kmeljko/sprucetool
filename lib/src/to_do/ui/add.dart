import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/ui/home.dart';

class ToDoAdd extends StatefulWidget {
  const ToDoAdd({Key? key, this.group, this.todo}) : super(key: key);

  final Group? group;
  final ToDo? todo;
  @override
  _ToDoAddState createState() => _ToDoAddState();
}

class _ToDoAddState extends State<ToDoAdd> {
  Controller controller = GetIt.I.get();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Add to do", withBack: true),
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
                  labelText: 'ToDo name',
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {
                  if (widget.group != null) {
                    await controller.addToDo(
                        widget.group!, textController.text, "parent");
                  } else {
                    await controller.addToDoAsChild(
                        widget.todo!, textController.text, "child");
                  }
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
