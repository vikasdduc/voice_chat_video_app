

import 'package:call_app/Utils/constants.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
String userUid = _auth.currentUser!.uid;


void initZegoUser(String userid, String name) {
  print("userid: inn initZegoUser ${userid}");
  print("name: inn initZegoUser ${name}");
  /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: appID /*input your AppID*/,
    appSign: appSign /*input your AppSign*/,
    userID: userid,
    userName: name,
    plugins: [
      ZegoUIKitSignalingPlugin(),
    ],
    notificationConfig: ZegoCallInvitationNotificationConfig(
      androidNotificationConfig: ZegoCallAndroidNotificationConfig(
        showFullScreen: true,
        fullScreenBackground: 'assets/call.png',
        channelID: "ZegoUIKit",
        channelName: "Call Notifications",
        sound: "call.mp3",
        icon: "call",
      ),
      // iOSNotificationConfig: ZegoCallIOSNotificationConfig(
      //   systemCallingIconName: 'CallKitIcon',
      // ),
    ),
    requireConfig: (ZegoCallInvitationData data) {
      final config = (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
          ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      // config.avatarBuilder = customAvatarBuilder;

      /// support minimizing, show minimizing button
      config.topMenuBar.isVisible = true;
      config.topMenuBar.buttons
          .insert(0, ZegoCallMenuBarButtonName.minimizingButton);

      return config;
    },
  );
}
