import 'package:call_app/Utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class CallPage extends StatefulWidget {
  const CallPage(
      {Key? key,
        // required this.callID,
        // required this.userID,
        // required this.username
      })
      : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  // final String callID;
  @override
  Widget build(BuildContext context) {
    return
      ZegoUIKitPrebuiltLiveAudioRoom(
        appID: appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userId,
        userName: userName,
        roomID: roomID,
        config: widget.isHost
               ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
               : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.

    );
  }
}