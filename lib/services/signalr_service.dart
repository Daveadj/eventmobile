import 'package:eventmobile/models/comment_model.dart';
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

  void onLoadComments(Function(List<Comment>?) callback) {
    hubConnection.on("LoadComments", (List<dynamic>? comments) {
      if (comments != null) {
        List<Comment> commentList = comments
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
        callback(commentList);
      } else {
        callback(null);
      }
    });
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
  }

  void onReceiveComment(Function(Comment) callback) {
    hubConnection.on("ReceiveComment", (dynamic commentJson) {
      Comment comment = Comment.fromJson(commentJson);
      callback(comment);
    });
  }

  Future<void> sendComment(int eventId, String body) async {
    await hubConnection.invoke("SendComment", args: [eventId, body]);
  }
}
