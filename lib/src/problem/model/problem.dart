import 'dart:convert';

import 'package:sprucetool/src/event/model/event.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';

class Problem extends ToDo {
  DateTime date;
  String description;
  List<Event> events;
  Problem({
    required id,
    required name,
    required creationTimestamp,
    required lastUpdateTimestamp,
    required this.date,
    required this.events,
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
      'events': events,
      'description': description,
    };
    Map<String, dynamic> superMap = super.toMap();
    return {}
      ..addAll(map)
      ..addAll(superMap);
  }

  @override
  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      creationTimestamp: DateTime.fromMillisecondsSinceEpoch(map['creation_timestamp']),
      lastUpdateTimestamp: DateTime.fromMillisecondsSinceEpoch(map['last_update_timestamp']),
      date: map['date'] ?? '',
      events: map['events'] ?? '',
      description: map['description'] ?? '',
    );
  }
  @override
  String toJson() => json.encode(toMap());

  @override
  factory Problem.fromJson(String source) =>
      Problem.fromMap(json.decode(source));
}
