import 'package:eventmobile/models/comment_model.dart';
import 'package:eventmobile/services/signalr_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignalRStateNotifier extends StateNotifier<List<Comment>> {
  SignalRStateNotifier() : super([]);

  final signalRService = SignalRService();

  Future<void> startConnection(int eventId) async {
    await signalRService.startConnection(eventId);
    signalRService.onLoadComments((comments) => state = comments!);
    signalRService.onReceiveComment((comment) => state = [...state, comment]);
  }

  Future<void> stopConnection() async {
    await signalRService.stopConnection();
  }

  void onReceiveComment(Function(dynamic) callback) {
    signalRService.onReceiveComment(callback);
  }

  Future<void> sendComment(int eventId, String body) async {
    await signalRService.sendComment(eventId, body);
  }
}

final signalRStateNotifier =
    StateNotifierProvider<SignalRStateNotifier, List<Comment>>(
        (ref) => SignalRStateNotifier());
