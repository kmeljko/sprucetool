import 'dart:convert';

import 'package:sprucetool/src/to_do/model/to_do.dart';

class Event extends ToDo {
  DateTime date;
  bool done;
  String description;
  Event({
    id,
    name,
    creationTimestamp,
    lastUpdateTimestamp,
    required this.date,
    required this.done,
    required this.description,
  }) : super(
            id: id,
            name: name,
            creationTimestamp: creationTimestamp,
            lastUpdateTimestamp: lastUpdateTimestamp);
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'done': done,
      'description': description,
    };
    Map<String, dynamic> superMap = super.toMap();
    return {}
      ..addAll(map)
      ..addAll(superMap);
  }

  @override
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      done: map['done'] ?? '',
      description: map['description'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
