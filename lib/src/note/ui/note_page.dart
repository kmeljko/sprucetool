import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/ui/notes.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);
  final Note note;
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Controller controller = GetIt.I.get();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.name;
    bodyController.text = widget.note.body;
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
                widget.note.name = s;
                controller.updateNote(widget.note);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: bodyController,
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
                widget.note.body = s;
                controller.updateNote(widget.note);
              },
            ),
          ],
        )),
      ),
    );
  }
}
