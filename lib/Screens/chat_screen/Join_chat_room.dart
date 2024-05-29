
import 'package:call_app/Screens/chat_screen/chat_live.dart';
import 'package:call_app/Utils/constants.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class JoinChat extends StatefulWidget {
  const JoinChat({Key? key,
    //required this.userUid
  }) : super(key: key);

  //final String userUid;

  @override
  State<JoinChat> createState() => _JoinChatState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
 String userUid = _auth.currentUser!.uid;
class _JoinChatState extends State<JoinChat> {

    @override
  void initState(){
    ZIMKit().init(
        appID: appID,
      appSign: appSign,
      appSecret: appSecret,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<UserModel?> userDetails = ref.watch(userDetailsProvider);
            print("userdetail.value ${userDetails.value?.username}");
            return userDetails.when(
              data: (userModel) {
                if (userModel != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name: ${userModel.name}'),
                      Text('Email: ${userModel.emailId}'),
                      Text('Phone Number: ${userModel.phoneNumber}'),
                      Text('Username: ${userModel.username}'),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: ()async {
                            await ZIMKit().connectUser(
                              id: localUserID,
                              name : userModel.username,
                            );

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) =>
                                    ChatLive(userName: userModel.username)));
                          },
                          child: Text ("Join Chat Room")
                      )
                    ],
                  );
                } else {
                  return Text('User not found');
                }
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            );
          },
        ),
      ),
    );
  }
}
