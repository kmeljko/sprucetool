import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/note/ui/add.dart';
import 'package:sprucetool/src/note/ui/note_page.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

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
      appBar: appBar(widget.group.name+" - Notes", withBack: true),
      body: Center(
          child: ListView.builder(
        itemCount: widget.group.notes.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: controller.getNote(widget.group.notes[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Note note = snapshot.data as Note;
                return GestureDetector(
                    child: ListTile(
                      title: Text(note.name),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note.body, maxLines: 1),
                            Text("...")
                          ]),
                      isThreeLine: true,
                    ),
                    onTap: () {
                      Get.to(NotePage(note: note));
                    });
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
