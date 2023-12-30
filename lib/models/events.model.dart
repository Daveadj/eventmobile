// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewEvent {
  final int id;
  final String description;
  final DateTime startTime;
  final String title;
  final String location;
  final String organiserId;
  NewEvent({
    required this.id,
    required this.description,
    required this.startTime,
    required this.title,
    required this.location,
    required this.organiserId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'startTime': startTime.millisecondsSinceEpoch,
      'title': title,
      'location': location,
      'organiserId': organiserId,
    };
  }

  factory NewEvent.fromMap(Map<String, dynamic> map) {
    return NewEvent(
      id: map['id'] as int,
      description: map['description'] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      title: map['title'] as String,
      location: map['location'] as String,
      organiserId: map['organiserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewEvent.fromJson(String source) => NewEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}
