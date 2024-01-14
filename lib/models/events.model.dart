// To parse this JSON data, do
//
//     final newEvent = newEventFromJson(jsonString);

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
  String organizerName;
  List<Photo> photos;
  List<Ticket> tickets;

  NewEvent({
    required this.id,
    required this.description,
    required this.startTime,
    required this.title,
    required this.location,
    required this.organizerId,
    required this.organizerName,
    required this.photos,
    required this.tickets,
  });

  factory NewEvent.fromJson(Map<String, dynamic> json) => NewEvent(
        id: json["id"],
        description: json["description"],
        startTime: DateTime.parse(json["startTime"]),
        title: json["title"],
        location: json["location"],
        organizerId: json["organizerId"],
        organizerName:json["organizerName"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        tickets:
            List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "startTime": startTime.toIso8601String(),
        "title": title,
        "location": location,
        "organizerId": organizerId,
        "organizerName":organizerName,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
      };
}

class Photo {
  int id;
  String publicId;
  String url;

  Photo({
    required this.id,
    required this.publicId,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        publicId: json["publicId"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "publicId": publicId,
        "url": url,
      };
}

class Ticket {
  int id;
  String ticketName;
  double price;
  int eventId;

  Ticket({
    required this.id,
    required this.ticketName,
    required this.price,
    required this.eventId,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketName: json["ticketName"],
        price: json["price"],
        eventId: json["eventId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticketName": ticketName,
        "price": price,
        "eventId": eventId,
      };
}
