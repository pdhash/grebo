import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketDemo extends StatefulWidget {
  @override
  _SocketDemoState createState() => _SocketDemoState();
}

class _SocketDemoState extends State<SocketDemo> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    socketInitialize();
  }

  void socketInitialize() async {
    try {
      Socket socket = io(
          'http://3.110.6.163:3000/socket.io/',
          OptionBuilder()
              // .setTransports(['websocket'])
              .disableAutoConnect()
              .enableForceNewConnection()
              .build());
      print(socket.connected);
      socket.onConnect((data) {
        // print("userId -- $userID");
        print("Connect successfully $data ");
        // socket.emit(
        //     DefaultApiString.sendStatusUrl, {"UserID": userId, "UserType": "3"});
      });
      socket.onConnectError((data) {
        print("connection error !! $data");
      });
      // socket.on(DefaultApiString.getStatusUrl, (data) {
      //   recentOrderData.clear();
      //   print("Socket Data ======$data");
      //   recentOrderData.addAll(data["Order"]);
      // });
      // socket.on(DefaultApiString.changeStatusUrl, (data) {
      //   // recentOrderData.clear();
      //   final i = recentOrderData.indexWhere(
      //       (element) => element['_id'].toString() == data['_id'].toString());
      //   print("Index == $i");
      //   print("Index == ${data['_id']}");
      //   print("Index == ${recentOrderData[i]}");
      //   if (i != null && !i.isNegative) {
      //     recentOrderData[i] = data;
      //     recentOrderData.refresh();
      //   }
      // });
      // userType.value = userT;
      // userID.value = userId;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Send Message'),
          ),
          StreamBuilder(
            builder: (context, snapshot) =>
                Text(snapshot.hasData ? '${snapshot.data}' : ''),
          )
        ],
      ),
    );
  }
}
