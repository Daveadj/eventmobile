import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/events.model.dart';
import 'package:eventmobile/screens/Auth/provider/auth_notifier.dart';
import 'package:eventmobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends ChangeNotifier {
  ApiService apiService = ApiService();
  AuthNotifier authNotifier;

  HomeNotifier(this.authNotifier);
  List<NewEvent> _events = [];

  List<NewEvent> get events => _events;
  Future<void> fetchEvent(BuildContext context) async {
    Log.i('trying to get all event');
    try {
      Log.i(' getting all event');
      final response = await apiService.get('/Event/GetAllEvents');
      Log.i(response.body);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = [];
        _events = data.map((eventData) => NewEvent.fromMap(eventData)).toList();
        Log.i('got all event');
        notifyListeners();
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        authNotifier.logout(context);
      } else {
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
