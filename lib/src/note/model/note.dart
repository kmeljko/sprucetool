import 'dart:convert';

class Note {
  int id;
  String name;
  String body;
  DateTime creationTimestamp;
  DateTime lastUpdateTimestamp;
  Note({
    required this.id,
    required this.name,
    required this.body,
    required this.creationTimestamp,
    required this.lastUpdateTimestamp,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'body': body,
      'creationTimestamp': creationTimestamp.millisecondsSinceEpoch,
      'lastUpdateTimestamp': lastUpdateTimestamp.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(int id, Map<String, dynamic> map) {
    return Note(
      id: id,
      name: map['name'] ?? '',
      body: map['body'] ?? '',
      creationTimestamp: DateTime.fromMillisecondsSinceEpoch(map['creationTimestamp']??0),
      lastUpdateTimestamp: DateTime.fromMillisecondsSinceEpoch(map['lastUpdateTimestamp']??0),
    );
  }

  String toJson() => json.encode(toMap());
}
