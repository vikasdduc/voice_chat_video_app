
import 'package:call_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoCallScreen extends StatelessWidget {
   const VideoCallScreen({super.key, required this.userId, required this.userName,required this.confrenceID});
  final String userId;
  final String userName;
  final String confrenceID;
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: ZegoUIKitPrebuiltVideoConference(
        appID: appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userId,
        userName: userName,
        conferenceID: confrenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
        //controller: ZegoUIKitPrebuiltVideoConferenceController(),
      ),

    );
  }
}
