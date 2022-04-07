import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/note/ui/add.dart';
import 'package:sprucetool/src/note/ui/note_page.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/util/values/colors.dart';

class GroupNotes extends StatefulWidget {
  const GroupNotes({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupNotesState createState() => _GroupNotesState();
}

class _GroupNotesState extends State<GroupNotes> {
  Controller controller = GetIt.I.get();
  TextStyle style = TextStyle(color: Colors.white);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.group.name + " - Notes", withBack: true),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor(),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          note.name,
                          style: style,
                        ),
                        subtitle: Text(
                          note.body,
                          maxLines: 1,
                          style: style,
                        ),
                      ),
                      margin: EdgeInsets.all(8),
                    ),
                    onTap: () {
                      Get.off(NotePage(note: note));
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
          Get.off(NoteAdd(group: widget.group));
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
