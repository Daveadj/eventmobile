import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/comment_model.dart';
import 'package:eventmobile/services/storage.dart';
import 'package:signalr_netcore/errors.dart';
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
      Log.i(comments.toString());
      if (comments != null) {
        List<Comment> commentList = comments
            .expand((commentJsonList) => commentJsonList)
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();

        callback(commentList);
        Log.i(commentList.length.toString());
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
       Log.i(commentJson.toString());
      Comment comment = Comment.fromJson(commentJson);
      callback(comment);
    });
  }

  Future<void> sendComment(int eventId, String body) async {
    try {
      await hubConnection.invoke("SendComment", args: [eventId, body]);
    } catch (error) {
      // Handle the error appropriately
      print("Error sending comment: $error");
      if (error is GeneralError) {
        // Handle GeneralError type if needed
      } else {
        // Handle other error types or rethrow the error
        rethrow;
      }
    }
  }
}
