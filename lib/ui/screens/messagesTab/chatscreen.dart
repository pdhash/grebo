import 'package:flutter/material.dart';
import 'package:greboo/ui/shared/appbar.dart';

class ChatView extends StatelessWidget {
  final int index;

  const ChatView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Samira Sehgal'),
      // body: Chat(
      //
      //  messages: _messages,
      // onAttachmentPressed: _handleAtachmentPressed,
      // onMessageTap: _handleMessageTap,
      // onPreviewDataFetched: _handlePreviewDataFetched,
      // onSendPressed: _handleSendPressed,
      // user: _user,
      // ),
    );
  }
}

// Widget chatBox(String title) {
//   return Container(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Text(title),
//     ),
//   );
// }
