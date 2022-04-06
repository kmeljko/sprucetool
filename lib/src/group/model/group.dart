import 'dart:convert';

import 'package:sprucetool/src/date/model/date.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';

class Group {
  int id;
  String name;
  List<Note> notes;
  List<ToDo> toDoList;
  List<Date> dates;
  Group({
    required this.id,
    required this.name,
    this.notes = const [],
    this.toDoList = const [],
    this.dates = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'notes': notes,
      'to_do_list': toDoList,
      'dates': dates,
    };
  }

  factory Group.fromMap(id, Map<String, dynamic> map) {
    return Group(
      id: id,
      name: map['name'],
      // notes: (map.containsKey('notes')) ? map['notes'] : [],
      // toDoList: (map.containsKey('to_do_list')) ? map['to_do_list'] : [],
      // dates: (map.containsKey('dates')) ? map['dates'] : [],
    );
  }

  String toJson() => json.encode(toMap());
}
