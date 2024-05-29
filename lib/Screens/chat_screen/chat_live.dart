
import 'package:call_app/Screens/chat_screen/chat_page_popup.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatLive extends StatefulWidget {
  const ChatLive({super.key,required this.userName});
 final String userName;
  @override
  State<ChatLive> createState() => _ChatLiveState();
}

class _ChatLiveState extends State<ChatLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hii ${widget.userName}'),
        actions: [ChatPagePopup()],
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction){
         Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ZIMKitMessageListPage(
              conversationID: conversation.id,
              conversationType: conversation.type,
          );
         }));
        },

      ),
    );
  }
}
