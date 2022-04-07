import 'dart:convert';

class ToDo {
  int id;
  String name;
  DateTime creationTimestamp;
  DateTime lastUpdateTimestamp;
  String type;
  String description;
  //when
  DateTime? date;
  //is done?
  bool done;
  //children todo
  List<int> children;

  ToDo({
    required this.id,
    required this.name,
    required this.creationTimestamp,
    required this.lastUpdateTimestamp,
    required this.type,
    required this.description,
    this.date,
    required this.done,
    required this.children,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'creationTimestamp': creationTimestamp.millisecondsSinceEpoch,
      'lastUpdateTimestamp': lastUpdateTimestamp.millisecondsSinceEpoch,
      'type': type,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'done': done,
      'children': children,
    };
  }

  factory ToDo.fromMap(int id,Map<String, dynamic> map) {
    return ToDo(
      id: id,
      name: map['name'] ?? '',
      creationTimestamp: DateTime.fromMillisecondsSinceEpoch(map['creationTimestamp']),
      lastUpdateTimestamp: DateTime.fromMillisecondsSinceEpoch(map['lastUpdateTimestamp']),
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date']) : null,
      done: map['done'] ?? false,
      children: (map.containsKey('children')) ? List<int>.from(map['children']) : [],
    );
  }

  String toJson() => json.encode(toMap());

}
