import 'package:eventmobile/services/storage.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection hubConnection;

  Future<String> getAccessToken() async {
    final accessToken = await UserStorage.getToken();
    return accessToken!;
  }

  Future<void> startConnection(int eventId) async {
    // final logger = Logger(printer: CustomPrinter());
    hubConnection = HubConnectionBuilder()
        .withUrl(
            'https://eventapp-dev-ggxr.4.us-1.fl0.io/comment?eventId=$eventId',
            options: HttpConnectionOptions(
                accessTokenFactory: () => getAccessToken(),
                logMessageContent: true))
        .build();
    await hubConnection.start();
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
  }

  void onReceiveComment(Function(dynamic) callback) {
    hubConnection.on("ReceiveComment", callback);
  }

  Future<void> sendComment(int eventId, String body) async {
    await hubConnection.invoke("SendComment", args: [eventId, body]);
  }
}
