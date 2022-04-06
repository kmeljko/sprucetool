import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/note/ui/add.dart';

class GroupNotes extends StatefulWidget {
  const GroupNotes({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupNotesState createState() => _GroupNotesState();
}

class _GroupNotesState extends State<GroupNotes> {
  Controller controller = GetIt.I.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: widget.group.notes.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: controller.getNote(widget.group.notes[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Note note = snapshot.data as Note;
                return ListTile(
                  title: Text(note.name),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(NoteAdd(group: widget.group));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
