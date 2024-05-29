import 'package:call_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class LiveVoiceCallScreen extends StatefulWidget {
  final String roomID;
  final bool isHost;
 final String username;
   const LiveVoiceCallScreen(
      {Key? key,
        required this.isHost,
        required this.roomID,
        required this.username
      })
      : super(key: key);

  @override
  State<LiveVoiceCallScreen> createState() => _LiveVoiceCallScreenState();
}

class _LiveVoiceCallScreenState extends State<LiveVoiceCallScreen> {
  // final String callID;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveAudioRoom(
        appID: appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: widget.username,
        userName: 'user_${widget.username}',
        roomID: widget.roomID,
        config: widget.isHost
               ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
               : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
    );
  }

  // bool isHost(){
  //   return widget.isHost == 'yes'
  //       ? true
  //       : false;
  // }
}