
import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/Utils/constants.dart';
import 'package:call_app/firebase_options.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/zego_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class FirebaseServices {

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  static UserModel ? _currentUser;
  //static final  Uid = _firebaseAuth.currentUser!.uid;

  static UserModel? get currentUser {
    if(_currentUser == null) {
      throw Exception("_current userModel must not be null while using this getter");
    }
    return _currentUser;
  }

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> get buildViews =>
      _firebaseStore.collection('users').snapshots();

  static Future<bool> signUp({
    required String name,
   required String username,
  required String phoneNumber,
  required String emailId,
  required String password
  }) async {
    try{
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailId,
          password: password);

     final  UserModel user = UserModel(
        name: name,
        phoneNumber: phoneNumber,
        username: username,
        emailId: emailId,
      );

     if(cred.user != null){
       final docRef = _firebaseStore.collection('users').doc(cred.user!.uid);
       final doc = await docRef.get();
       if(doc.exists){
         print("user already exist");
         return false;
       }
       await docRef.set(user.toJson());
       return true;
     }
     return false;
    } catch (e){
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> login({
    required String emailId,
    required String password,
    context
  }) async {
    try{
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailId,
          password: password);

      if (cred.user != null) {
        final doc = _firebaseStore.collection('users').doc(cred.user!.uid);
        final snapshot = await doc.get();
        final data = snapshot.data();
        print('user data firebase $data');
        if (data != null) {
          _currentUser = UserModel.fromJson(data);
          var userid  = _currentUser!.username;
          var name  = _currentUser!.name;
          initZegoUser(userid, name);
          return true;
        }
      }
      return false;
    } catch (e){
      debugPrint(e.toString());
      return false;
    }
  }

  static Future logout() async {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    await _firebaseAuth.signOut();
  }

  // check whether the user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }


}
