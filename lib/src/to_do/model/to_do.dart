import 'dart:convert';

class ToDo {
  String id;
  String name;
  DateTime creationTimestamp;
  DateTime lastUpdateTimestamp;
  ToDo({
    required this.id,
    required this.name,
    required this.creationTimestamp,
    required this.lastUpdateTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creation_timestamp': creationTimestamp.millisecondsSinceEpoch,
      'last_update_timestamp': lastUpdateTimestamp.millisecondsSinceEpoch,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      creationTimestamp: DateTime.fromMillisecondsSinceEpoch(map['creation_timestamp']),
      lastUpdateTimestamp: DateTime.fromMillisecondsSinceEpoch(map['last_update_timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));
}
