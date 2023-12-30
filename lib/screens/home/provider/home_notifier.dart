import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/events.model.dart';
import 'package:eventmobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends ChangeNotifier {
  ApiService apiService = ApiService();
  List<NewEvent> _events = [];

  List<NewEvent> get events => _events;
  Future<void> fetchEvent() async {
    Log.i('trying to get all event');
    try {
      final response = await apiService.get('Event/GetAllEvents');
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = [];
        _events = data.map((eventData) => NewEvent.fromMap(eventData)).toList();
        notifyListeners();
      }
    } catch (e) {
      Log.i('Error: $e');
      throw Exception('Failed to load events');
    }
  }
}

var homeNotifierProvider =
    ChangeNotifierProvider<HomeNotifier>((ref) => HomeNotifier());
