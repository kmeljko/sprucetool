import 'dart:convert';

class Date {
  int id;
  String name;
  DateTime date;
  String description;
  Date({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'description': description,
    };
  }

  factory Date.fromMap(Map<String, dynamic> map) {
    return Date(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Date.fromJson(String source) => Date.fromMap(json.decode(source));
}
