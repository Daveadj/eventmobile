// To parse this JSON data, do
//
//     final createEvent = createEventFromJson(jsonString);

import 'dart:convert';

CreateEvent createEventFromJson(String str) =>
    CreateEvent.fromJson(json.decode(str));

String createEventToJson(CreateEvent data) => json.encode(data.toJson());

class CreateEvent {
  CreateEventClass createEvent;
  CreateTicket createTicket;

  CreateEvent({
    required this.createEvent,
    required this.createTicket,
  });

  factory CreateEvent.fromJson(Map<String, dynamic> json) => CreateEvent(
        createEvent: CreateEventClass.fromJson(json["createEvent"]),
        createTicket: CreateTicket.fromJson(json["createTicket"]),
      );

  Map<String, dynamic> toJson() => {
        "createEvent": createEvent.toJson(),
        "createTicket": createTicket.toJson(),
      };
}

class CreateEventClass {
  String description;
  DateTime startTime;
  String title;
  String location;

  CreateEventClass({
    required this.description,
    required this.startTime,
    required this.title,
    required this.location,
  });

  factory CreateEventClass.fromJson(Map<String, dynamic> json) =>
      CreateEventClass(
        description: json["description"],
        startTime: DateTime.parse(json["startTime"]),
        title: json["title"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "startTime": startTime.toIso8601String(),
        "title": title,
        "location": location,
      };
}

class CreateTicket {
  String ticketName;
  String price;

  CreateTicket({
    required this.ticketName,
    required this.price,
  });

  factory CreateTicket.fromJson(Map<String, dynamic> json) => CreateTicket(
        ticketName: json["ticketName"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "ticketName": ticketName,
        "price": price,
      };
}
