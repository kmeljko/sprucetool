import 'package:sprucetool/src/date/model/date.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';

class Group {
  String id;
  List<Note> notes;
  List<ToDo> toDoList;
  List<Date> dates;
  Group({
    required this.id,
    this.notes = const [],
    this.toDoList = const [],
    this.dates = const [],
  });
}
