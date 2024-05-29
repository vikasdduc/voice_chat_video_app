import 'package:call_app/Screens/contact_screen/contact_list_screen.dart';
import 'package:call_app/Screens/home_grid_view/home_grid_view_button.dart';
import 'package:call_app/Utils/drawer.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:call_app/services/zego_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen/Join_chat_room.dart';
import 'join_call/join_call_screen.dart';

class BottomHomePage extends StatefulWidget {
  const BottomHomePage({Key? key}) : super(key: key);

  @override
  _BottomHomePageState createState() => _BottomHomePageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _store = FirebaseFirestore.instance;

class _BottomHomePageState extends State<BottomHomePage> {
  int pageIndex = 0;
 //late String ? username ;
  final pages = [
    const ContactListScreen(),
    const JoinChat(),
    const JoinCallScreen(),
    const HomeGridViewButton(),
  ];

  @override
  void initState() {
    final String userUid = _auth.currentUser!.uid;
    print("uid: $userUid");
    //FirebaseServices().getUserData();
     // String? username = FirebaseServices.currentUser?.username;
     print("userName");
    //initZegoUser();
    super.initState();
  // print("userdat : ${userdata}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawer(),
      backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        // leading: Icon(
        //   Icons.menu,
        //   color: Theme.of(context).primaryColor,
        // ),
        title: Text(
          "Home",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.contact_phone_sharp,
              color: Colors.white,
              size: 35,
              semanticLabel: 'Users list',
            )
                : const Icon(
              Icons.contact_phone_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                    size: 35,
                semanticLabel: 'Chat',
                  )
                : const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.video_call,
              color: Colors.white,
              size: 35,
              semanticLabel: 'Video Call',
            )
                : const Icon(
              Icons.video_call_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
              semanticLabel: 'Home',
            )
                : const Icon(
              Icons.holiday_village_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
