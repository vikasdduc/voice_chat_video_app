
import 'dart:ffi';

import 'package:call_app/Screens/chat_screen/Join_chat_room.dart';
import 'package:call_app/Screens/chat_screen/chat_live.dart';
import 'package:call_app/Screens/video_call_confrence/video_live_screen.dart';
import 'package:call_app/Utils/constants.dart';
import 'package:call_app/login_screen/auth_services.dart';
import 'package:call_app/login_screen/phone_page.dart';
import 'package:call_app/login_screen/sign_in_landing_page.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:call_app/services/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class JoinCallScreen extends StatefulWidget {
  const JoinCallScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JoinCallScreenState();
}

TextEditingController isHostController = TextEditingController();

TextEditingController roomIdController = TextEditingController();

TextEditingController userNameController = TextEditingController();

FirebaseAuth _auth = FirebaseAuth.instance;
String userUid = _auth.currentUser!.uid;

class _JoinCallScreenState extends State<JoinCallScreen> {
  static final _keyValidationForm = GlobalKey<FormState>();
  bool _isHostSelected = false;

    @override
  void initState(){
    ZIMKit().init(
        appID: appID,
      appSign: appSign,
      appSecret: appSecret,
      // notificationConfig: ZegoZIMKitNotificationConfig(
      //   resourceID: "",
      //   androidNotificationConfig: ZegoZIMKitAndroidNotificationConfig(
      //     channelID: '',
      //     channelName: '',
      //     icon: '',
      //     sound: '',
      //     vibrate: true,
      //   )
      // )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final AsyncValue<UserModel?> userDetails = ref.watch(userDetailsProvider);
            return userDetails.when(
                data: (userdata){
                  userNameController.text = userdata!.username;
                  // saveUserToSF(userDetails.value!);
                  // addStringToSF(userdata.phoneNumber, userdata.username);
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1,
                        child:Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          margin: const EdgeInsets.all(16),
                          child: Form(
                            key: _keyValidationForm,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // // button for voice call ishosted
                                  // const Text(
                                  //   'Start a Group call or Join?',
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // const SizedBox(height: 16),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     ElevatedButton(
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           _isHostSelected = true;
                                  //         });
                                  //       },
                                  //       style: ElevatedButton.styleFrom(
                                  //         backgroundColor: _isHostSelected ? Colors.green : Colors.grey,
                                  //       ),
                                  //       child: const Text('START'),
                                  //     ),
                                  //     const SizedBox(width: 50),
                                  //     ElevatedButton(
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           _isHostSelected = false;
                                  //         });
                                  //       },
                                  //       style: ElevatedButton.styleFrom(
                                  //         backgroundColor: !_isHostSelected ? Colors.green : Colors.white,
                                  //       ),
                                  //       child: const Text('JOIN'),
                                  //     ),
                                  //   ],
                                  // ),
                                  //
                                  const SizedBox(height: 20,),
                                  TextFormField(
                                    validator: _validateRoomId,
                                    controller: roomIdController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.meeting_room_rounded),
                                      hintText: "Enter Common Room ID",
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  TextFormField(
                                    validator: _validateUserName,
                                    controller: userNameController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.account_box_sharp),
                                      hintText: "please enter Your Name",
                                    ),
                                  ),

                                  // //voice grop call commented
                                  //const SizedBox(height: 20,),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       if(_keyValidationForm.currentState!.validate()){
                                  //         Navigator.push(
                                  //             context,
                                  //             MaterialPageRoute(
                                  //                 builder: (context) => LiveCallScreen(
                                  //                   isHost: _isHostSelected,
                                  //                   roomID: roomIdController.text.trim(), //VideoCallScreen
                                  //                   username: userNameController.text.trim(),
                                  //                 )));
                                  //
                                  //       }
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(25.0)),
                                  //         backgroundColor: _isHostSelected ? Colors.green[200] : Colors.greenAccent[200],
                                  //         foregroundColor: Colors.black
                                  //     ),
                                  //     child: _isHostSelected ? const Text('Start Voice Group Call ',style: TextStyle(),) : const Text('Join Voice Group Call')
                                  // ),

                                  const SizedBox(height: 20,),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_keyValidationForm.currentState!.validate()){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => VideoCallScreen(

                                                    userId: localUserID,
                                                    userName: userNameController.text.trim(),
                                                    confrenceID: roomIdController.text.trim(), //JoinChat(),
                                                  )));

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0)),
                                          backgroundColor: _isHostSelected ? Colors.orange[200] : Colors.deepOrangeAccent[200],
                                          foregroundColor: Colors.black
                                      ),
                                      child: _isHostSelected ? const Text('Start Video Group Call ') : const Text('Join Video Group Call')
                                  ),
                                  const SizedBox(height: 20,),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if(_keyValidationForm.currentState!.validate()){
                                          await ZIMKit().connectUser(
                                            id: localUserID,
                                            name : userNameController.text.trim(),
                                          );

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (context) =>
                                                  ChatLive(userName: userNameController.text.trim())));

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0)),
                                          backgroundColor: _isHostSelected ? Colors.blue[200] : Colors.blueAccent[200],
                                          foregroundColor: Colors.black
                                      ),
                                      child: _isHostSelected ? const Text('Start Group Chat') : const Text('Join Group Chat')
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Are you sure you want to logout?"),
                              //content: Text("Enter 6-digit OTP"), // Add your OTP input field here if needed
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Handle logout action
                                    AuthService.logout();
                                    FirebaseServices.logout();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => const SignInLandingPage())); // Close the dialog
                                  },
                                  child: const Text("Log Out"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog without logging out
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("Log Out"), // Your button child widget
                      ),
                    ],
                  );
                },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            );

          },
          // child: (context, ref) {

          // }
        ),
      ),
    );
  }
  String? _validateUserName(String? value) {
    return value?.trim().isEmpty ?? true ? "Name can't be empty" : null;
  }
  String? _validateRoomId(String? value) {
    return value!.length < 5 ? "'Min 5 char required'" : null;
  }

  // addStringToSF(phoneNumber,userName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //prefs.setString(phoneNumber, userName);
  //   await prefs.setString('phoneNumber', phoneNumber);
  //   await prefs.setString('userName', userName);
  // }
  //
  // Future<void> saveUserToSF(UserModel user) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_name', user.name);
  //   prefs.setString('user_username', user.username);
  //   prefs.setString('user_phoneNumber', user.phoneNumber);
  //   prefs.setString('user_emailId', user.emailId ?? '');
  // }
  // Future<String> username() async{
  //   final AsyncValue<UserModel?> userDetails =  await ref.read(userDetailsProvider(userUid));
  //   String userName  = userDetails.value!.username;
  //   print("join call card Username : $userName");
  //   userNameController.text = userName != null ? userName : userNameController.text;
  //
  //     return userNameController.text;
  // }

}
