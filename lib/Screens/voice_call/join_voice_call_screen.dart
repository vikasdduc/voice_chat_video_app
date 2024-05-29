
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'live_voice_calls.dart';

TextEditingController isHostController = TextEditingController();

TextEditingController roomIdController = TextEditingController();

TextEditingController userNameController = TextEditingController();


class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});


  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  static final _keyValidationForm = GlobalKey<FormState>();
  bool _isHostSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        foregroundColor: Colors.black,
        elevation: 10,
        title: const Text('Group Call', style: TextStyle(fontSize: 35),),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         Navigator.pushNamed(context, '/contact_call_tabbar');
        //       },
        //       icon: const Icon(Icons.contact_phone_rounded))
        // ],
      ),
      body:
      Center(
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
                                  // button for voice call ishosted
                                  const Text(
                                    'Start a Group call or Join?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _isHostSelected = true;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _isHostSelected ? Colors.green : Colors.grey,
                                        ),
                                        child: const Text('START'),
                                      ),
                                      const SizedBox(width: 50),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _isHostSelected = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: !_isHostSelected ? Colors.green : Colors.white,
                                        ),
                                        child: const Text('JOIN'),
                                      ),
                                    ],
                                  ),

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
                                  const SizedBox(height: 20,),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_keyValidationForm.currentState!.validate()){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => LiveVoiceCallScreen(
                                                    isHost: _isHostSelected,
                                                    roomID: roomIdController.text.trim(), //VideoCallScreen
                                                    username: userNameController.text.trim(),
                                                  )));

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0)),
                                          backgroundColor: _isHostSelected ? Colors.green[200] : Colors.greenAccent[200],
                                          foregroundColor: Colors.black
                                      ),
                                      child: _isHostSelected ? const Text('Start Voice Group Call ',style: TextStyle(),) : const Text('Join Voice Group Call')
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) => AlertDialog(
                      //         title: const Text("Are you sure you want to logout?"),
                      //         //content: Text("Enter 6-digit OTP"), // Add your OTP input field here if needed
                      //         actions: [
                      //           TextButton(
                      //             onPressed: () {
                      //               // Handle logout action
                      //               AuthService.logout();
                      //               FirebaseServices.logout();
                      //               Navigator.pushReplacement(
                      //                   context, MaterialPageRoute(builder: (context) => const SignInLandingPage())); // Close the dialog
                      //             },
                      //             child: const Text("Log Out"),
                      //           ),
                      //           TextButton(
                      //             onPressed: () {
                      //               Navigator.of(context).pop(); // Close the dialog without logging out
                      //             },
                      //             child: const Text("Cancel"),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      //   child: const Text("Log Out"), // Your button child widget
                      // ),
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
      ),
      // Center(
      //   child: Column(
      //     children: [
      //       // ZegoUIKitPrebuiltLiveAudioRoomMiniOverlayPage(contextQuery: () {
      //       //
      //       // },),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width / 1,
      //         child:Card(
      //           color: Colors.white,
      //           elevation: 4,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12.0),
      //           ),
      //           margin: const EdgeInsets.all(16),
      //           child: Form(
      //             key: _keyValidationForm,
      //             child: Padding(
      //               padding: const EdgeInsets.all(16),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
      //                 children: [
      //                   const Text(
      //                     'Start a Group call or Join?',
      //                     style: TextStyle(
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                   const SizedBox(height: 16),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       ElevatedButton(
      //                         onPressed: () {
      //                           setState(() {
      //                             _isHostSelected = true;
      //                           });
      //                         },
      //                         style: ElevatedButton.styleFrom(
      //                           backgroundColor: _isHostSelected ? Colors.green : Colors.grey,
      //                         ),
      //                         child: const Text('START'),
      //                       ),
      //                       const SizedBox(width: 50),
      //                       ElevatedButton(
      //                         onPressed: () {
      //                           setState(() {
      //                             _isHostSelected = false;
      //                           });
      //                         },
      //                         style: ElevatedButton.styleFrom(
      //                           backgroundColor: !_isHostSelected ? Colors.green : Colors.white,
      //                         ),
      //                         child: const Text('JOIN'),
      //                       ),
      //                     ],
      //                   ),
      //                   // SizedBox(height: 16),
      //                   // ElevatedButton(
      //                   //   onPressed: () {
      //                   //     // Use the _isHostSelected value as needed (true for host, false for audience)
      //                   //     print('Is Host Selected? $_isHostSelected');
      //                   //   },
      //                   //   child: Text('Submit'),
      //                   // ),
      //                   const SizedBox(height: 20,),
      //                   TextFormField(
      //                     validator: _validateRoomId,
      //                     controller: roomIdController,
      //                     decoration: const InputDecoration(
      //                       prefixIcon: Icon(Icons.meeting_room_rounded),
      //                       hintText: "please enter Room ID",
      //                     ),
      //                   ),
      //                   const SizedBox(height: 20,),
      //                   TextFormField(
      //                     validator: _validateUserName,
      //                     controller: userNameController,
      //                     decoration: const InputDecoration(
      //                       prefixIcon: Icon(Icons.account_box_sharp),
      //                       hintText: "please enter Your Name",
      //                     ),
      //                   ),
      //                   const SizedBox(height: 20,),
      //                   ElevatedButton(
      //                       onPressed: () {
      //                         if(_keyValidationForm.currentState!.validate()){
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => LiveVoiceCallScreen(
      //                                     isHost: _isHostSelected,
      //                                     roomID: roomIdController.text.trim(),
      //                                     username: userNameController.text.trim(),
      //                                   )));
      //
      //                         }
      //                       },
      //                       style: ElevatedButton.styleFrom(
      //                         shape: RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(25.0)),
      //                           backgroundColor: _isHostSelected ? Colors.green : Colors.yellow,
      //                           foregroundColor: Colors.black
      //                       ),
      //                       child: _isHostSelected ? const Text('Start Group Call ') : const Text('Join Group Call')
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //         ),
      //       const SizedBox(height: 20,),
      //       ElevatedButton(
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) => AlertDialog(
      //               title: const Text("Are you sure you want to logout?"),
      //               //content: Text("Enter 6-digit OTP"), // Add your OTP input field here if needed
      //               actions: [
      //                 TextButton(
      //                   onPressed: () {
      //                     // Handle logout action
      //                     AuthService.logout();
      //                     Navigator.pushReplacement(
      //                         context, MaterialPageRoute(builder: (context) => const NumberLoginPage())); // Close the dialog
      //                   },
      //                   child: const Text("Log Out"),
      //                 ),
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop(); // Close the dialog without logging out
      //                   },
      //                   child: const Text("Cancel"),
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //         child: const Text("Log Out"), // Your button child widget
      //       )
      //
      //     ],
      //   ),
      // ),
    );
  }
  String? _validateUserName(String? value) {
    return value?.trim().isEmpty ?? true ? "Name can't be empty" : null;
  }
  String? _validateRoomId(String? value) {
    return value!.length < 5 ? "'Min 5 char required'" : null;
  }
}