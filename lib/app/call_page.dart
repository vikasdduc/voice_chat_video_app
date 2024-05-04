import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
        required this.callID,
        required this.userID,
        required this.username})
      : super(key: key);
  final String callID;
  final String userID;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID:
        145081645, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
        "c655f6c3dc4edb513e643e2bd4026aa7f545d3f7ceefca111d7df4e33f6b9397", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userID,
        userName: username,
        callID: callID,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}