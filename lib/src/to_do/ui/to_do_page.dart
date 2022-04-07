import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';
import 'package:sprucetool/src/to_do/ui/add.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key, required this.todo}) : super(key: key);
  final ToDo todo;
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  Controller controller = GetIt.I.get();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.name;
    descriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBar("", withBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelText: 'Title',
              ),
              onChanged: (s) {
                widget.todo.name = s;
                controller.updateToDo(widget.todo);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelText: 'Body',
              ),
              onChanged: (s) {
                widget.todo.description = s;
                controller.updateToDo(widget.todo);
              },
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ToDoAdd(todo:widget.todo));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
