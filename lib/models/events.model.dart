import 'dart:convert';

NewEvent newEventFromJson(String str) => NewEvent.fromJson(json.decode(str));

String newEventToJson(NewEvent data) => json.encode(data.toJson());

class NewEvent {
    int id;
    String description;
    DateTime startTime;
    String title;
    String location;
    String organizerId;

    NewEvent({
        required this.id,
        required this.description,
        required this.startTime,
        required this.title,
        required this.location,
        required this.organizerId,
    });

    factory NewEvent.fromJson(Map<String, dynamic> json) => NewEvent(
        id: json["id"],
        description: json["description"],
        startTime: DateTime.parse(json["startTime"]),
        title: json["title"],
        location: json["location"],
        organizerId: json["organizerId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "startTime": startTime.toIso8601String(),
        "title": title,
        "location": location,
        "organizerId": organizerId,
    };
}
