
import 'package:call_app/model/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final UserModel userData;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 1,
              color: Colors.grey.withOpacity(.2),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 25,
              child: Center(
                child: Text(
                  widget.userData.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userData.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.userData.phoneNumber,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            actionButton(false),
            actionButton(true),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  ZegoSendCallInvitationButton actionButton(bool isVideo) {
    return ZegoSendCallInvitationButton(
      //onPressed: ,
      isVideoCall: isVideo,
      resourceID: "call_app",
      invitees: [
        ZegoUIKitUser(
          id: widget.userData.username,
          name: widget.userData.name,
        ),
      ],
      iconSize: const Size(40, 40),
      buttonSize: Size(60, 60), // Adjust the button size as needed
    );
  }
}

// class UserCard extends StatefulWidget {
//   const UserCard({super.key,
//     required this.userData,
//   });
// final UserModel userData;
//
//   @override
//   State<UserCard> createState() => _UserCardState();
// }
//
// class _UserCardState extends State<UserCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(padding: EdgeInsets.only(bottom: 12.0),
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       height: 110,
//       padding: EdgeInsets.all(15.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.5),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(10,20),
//             blurRadius: 10,
//             spreadRadius: 0,
//             color: Colors.grey.withOpacity(.05),
//           )
//         ]
//       ),
//       child: Expanded(
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Theme.of(context).primaryColor,
//               radius: 25,
//               child: Center(
//                 child: Text(
//                   widget.userData.name.substring(0,1).toUpperCase(),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//             Column(
//               children: [
//                 Text(
//                   widget.userData.name,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   widget.userData.phoneNumber,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             // SizedBox(
//             //   height: MediaQuery.of(context).size.height,
//             //   width: MediaQuery.of(context).size.width,
//             //   child: actionButton(false),
//             // ),
//             // SizedBox(
//             //   height: MediaQuery.of(context).size.height,
//             //   width: MediaQuery.of(context).size.width,
//             //   child: actionButton(true),
//             //),
//             // video call button
//             actionButton(false),
//             const SizedBox(
//               width: 5,
//             ),
//             actionButton(true),
//             const SizedBox(
//               width: 5,
//             ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }
//   ZegoSendCallInvitationButton actionButton(bool isVideo) =>
//       ZegoSendCallInvitationButton(
//         //notificationTitle: 'C',
//         //margin: ,
//         buttonSize: Size(30,30),
//         isVideoCall: isVideo,
//         resourceID: "call_app",
//         invitees: [
//           ZegoUIKitUser(
//             id: widget.userData.username,
//             name: widget.userData.name,
//           ),
//         ],
//       );
//
// }
