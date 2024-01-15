// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/create_event_model.dart';
import 'package:eventmobile/models/events.model.dart';
import 'package:eventmobile/screens/Auth/provider/auth_notifier.dart';
import 'package:eventmobile/screens/entryPoint/entry_point.dart';
import 'package:eventmobile/screens/home/add_sample.dart';
import 'package:eventmobile/services/api_service.dart';
import 'package:eventmobile/services/loader.dart';
import 'package:eventmobile/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends ChangeNotifier {
  ApiService apiService = ApiService();
  AuthNotifier authNotifier;

  HomeNotifier(this.authNotifier);
  List<NewEvent> _events = [];
  // ignore: prefer_final_fields
  List<NewEvent> _recentEvents = [];

  List<NewEvent> get events => _events;
  List<NewEvent> get recentEvents => _recentEvents;

  Future<void> fetchEvent(BuildContext context) async {
    Log.i('trying to get all event');
    try {
      Log.i(' getting all event');
      final response = await apiService.get('/Event/GetAllEvents');

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _events =
            data.map((eventData) => NewEvent.fromJson(eventData)).toList();
        _recentEvents = _events.where(
          (event) {
            DateTime eventDate = event.startTime;
            DateTime currentDate = DateTime.now();

            // Change the condition to filter events for today
            return eventDate.year == currentDate.year &&
                eventDate.month == currentDate.month &&
                eventDate.day == currentDate.day;
          },
        ).toList();
        Log.i(_recentEvents.length.toString());
        Log.i('got all event');
        notifyListeners();
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        authNotifier.logout(context);
      } else {
        Log.i('${response.statusCode}');
      }
    } catch (e) {
      Log.i('Error: $e');
      throw Exception('Failed to load events');
    }
  }

  Future<void> createEvent(BuildContext context, CreateEventClass createEvent,
      CreateTicket ticket, File file) async {
    final loader = Loader(context: context);
    final Map<String, dynamic> body = {
      'CreateEventDto.Description': createEvent.description,
      'CreateEventDto.startTime': createEvent.startTime,
      'CreateEventDto.Title': createEvent.title,
      'CreateEventDto.Location': createEvent.location,
      'CreateTicketDto.TicketName': ticket.ticketName,
      'CreateTicketDto.Price': ticket.price,
    };
    Log.i('creating event');
    try {
      loader.show();
      Log.i(' trying to create event');
      final response = await apiService.postMultipartRequest(
        '/Event/CreateEventWithPhoto',
        image: file,
        body: body,
      );
      Log.i(response.body);
      loader.close();

      if (response.statusCode == 200) {
        SnackBarHelper.showErrorSnackBar(context, response.body, true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const EntryPoint(),
          ),
        );
        notifyListeners();
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        authNotifier.logout(context);
      } else {
        SnackBarHelper.showErrorSnackBar(
            context, 'Error creating event, try again later', false);
        Log.i('${response.statusCode}');
      }
    } catch (e) {
      Log.i('Error: $e');
      throw Exception('Failed to load events');
    }
  }
}

var homeNotifierProvider = ChangeNotifierProvider<HomeNotifier>(
    (ref) => HomeNotifier(ref.read(authNotifierProvider)));
