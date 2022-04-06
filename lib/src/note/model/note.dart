import 'dart:convert';

class Note {
  int id;
  String body;
  DateTime creationTimestamp;
  DateTime lastUpdateTimestamp;
  Note({
    required this.id,
    required this.body,
    required this.creationTimestamp,
    required this.lastUpdateTimestamp,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'creation_timestamp': creationTimestamp.millisecondsSinceEpoch,
      'last_update_timestamp': lastUpdateTimestamp.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      body: map['body'] ?? '',
      creationTimestamp: DateTime.fromMillisecondsSinceEpoch(map['creation_timestamp']),
      lastUpdateTimestamp: DateTime.fromMillisecondsSinceEpoch(map['last_update_timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}
