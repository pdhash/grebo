import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/service/repo/chatRepo.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/messagesTab/model/chatListModel.dart';
import 'package:grebo/ui/screens/messagesTab/model/messageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenController extends GetxController {
  final TextEditingController messageText = TextEditingController();
  LastMessage? lastMessage;

  String businessRef = "";
  String channelRef = "";
  Future fetchChannel() async {
    SocketManager.socketDisconnect();
    SocketManager.connectSocket(() async {
      print("getChannel...");
      var response = await ChatRepo.getChannel(businessRef);
      channelRef = response["data"]["channelId"];
      connectChannelToSocket();
      setupSocketListener();
      fetchMessages();
    });
  }

  void setupSocketListener() {
    print("setupSocketListener...");
    readAllMsg();
    SocketManager.socket!.on('message', (data) {
      print("GET message ${data}");
      readAllMsg();
      var messageData = MessageData(
          createdAt: DateTime.parse(data["createdOn"]),
          userId: data["userId"],
          picture: "",
          message: data["message"]);
      getMessages.insert(0, messageData);
      lastMessage = LastMessage(
          message: messageData.message,
          createdAt: messageData.createdAt,
          user: User(name: '', id: messageData.userId, picture: ''));

      print("ON MSG ARR ${getMessages.length}");
      update();
    });
  }

  void readAllMsg() {
    SocketManager.socket!.emit(
        'read_all', {"channelRef": channelRef, "id": userController.user.id});
  }

  late bool _hasNext;
  bool _isFetching = false;
  bool get hasNext => _hasNext;
  int page = 0;

  List<MessageData> getMessages = [];
  Future fetchMessages() async {
    page = 0;
    _isFetching = false;
    getMessages.clear();
    await fetchNextMessages();
  }

  Future fetchNextMessages() async {
    if (_isFetching) return;
    _isFetching = true;
    page++;
    var request =
        await ChatRepo.getAllMessages(page: page, channelRef: channelRef);
    getMessages.addAll(request!.data.map((e) => e));
    print("GET MSG ARR ${getMessages.length}");
    _hasNext = request.hasMore;
    _isFetching = false;
    update();
  }

  Future sendMessages() async {
    String msg = messageText.text.trim();
    messageText.clear();
    print("sendMessages");
    SocketManager.socket!.emit('message', {
      "channelRef": channelRef,
      "message": msg,
      "id": userController.user.id
    });
  }

  connectChannelToSocket() {
    print("connectChannelToSocket");
    SocketManager.socket!.emit("subscribe_channel", {"channelRef": channelRef});
    SocketManager.socket!
        .emit("subscribe_user", {"userRef": userController.user.id});
  }

  @override
  void dispose() {
    SocketManager.socketDisconnect();

    super.dispose();
  }
}

class SocketManager {
  static IO.Socket? socket;
  static void connectSocket(Function onConnect) {
    socket = IO.io(
        socketBaseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({"authorization": userController.userToken})
            .setQuery({"id": userController.user.id})
            .disableAutoConnect()
            .enableForceNew() // disable auto-connection
            .build());
    socket!.connect();

    socket!.onConnect((_) {
      print('connectted');
      onConnect();
    });
    socket!.onConnecting((data) => print("onConnecting ${data}"));
    socket!.onConnectError((data) => print("onConnectError ${data}"));
    socket!.onError((data) => print("onError ${data}"));
    socket!.onDisconnect((data) => print("onDisconnect $data"));
  }

  static void socketDisconnect() {
    if (SocketManager.socket != null) {
      SocketManager.socket!.disconnect();
      socket!.onDisconnect((data) => print("onDisconnect $data"));
    }
  }
}
