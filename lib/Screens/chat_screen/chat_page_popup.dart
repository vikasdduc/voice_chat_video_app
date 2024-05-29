
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatPagePopup extends StatefulWidget {
  const ChatPagePopup({super.key});

  @override
  State<ChatPagePopup> createState() => _ChatPagePopupState();
}

TextEditingController userIdController = TextEditingController();
TextEditingController groupNameController = TextEditingController();
TextEditingController userUsersController = TextEditingController();
TextEditingController groupIDController = TextEditingController();

class _ChatPagePopupState extends State<ChatPagePopup> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
        position: PopupMenuPosition.under,
        icon: Icon(Icons.add_circle_outline),
        
        itemBuilder: (context){
         return [
           PopupMenuItem(
             value: 'New Chat',
             child: ListTile(
               leading: Icon(Icons.chat_bubble),
               title: Text("New Chat", maxLines: 1,),
             ),
             onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
         ),
           PopupMenuItem(
             value: 'New Group',
             child: ListTile(
               leading: Icon(Icons.person_add_alt),
               title: Text("New Group", maxLines: 1,),
             ),
             onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
           ),
           PopupMenuItem(
             value: 'Join Group',
             child: ListTile(
               leading: Icon(Icons.group_add),
               title: Text("Join Group", maxLines: 1,),
             ),
             onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
           ),
         ];
        }
    );
  }
}
