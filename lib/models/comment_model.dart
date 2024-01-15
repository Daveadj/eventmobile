import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  final int id;
  final String body;
  final String authorId;
  final String authorUsername;
  final int eventId;
  final String photoUrl;
  final DateTime date;

  Comment(
      {required this.id,
      required this.body,
      required this.authorId,
      required this.eventId,
      required this.authorUsername,
      required this.photoUrl,
      required this.date});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        authorId: json["authorId"],
        authorUsername: json["authorUsername"],
        photoUrl: json["photoUrl"],
        eventId: json["eventId"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "authorId": authorId,
        "authorUsername":authorUsername,
        "eventId": eventId,
        "photoUrl":photoUrl,
        "date": date.toIso8601String()
      };
}
