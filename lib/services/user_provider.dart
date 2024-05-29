import 'dart:async';

import 'package:call_app/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final userDetailsProvider = FutureProvider<UserModel?>((ref) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String userUid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(userUid).get();

    if (snapshot.exists) {
      // Convert Firestore data to UserModel object using fromJson method
      return UserModel.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return null;
  }
});

final allUserProvider = StreamProvider<List<UserModel>>((ref) {
  try {
    // Stream of QuerySnapshot from Firestore
    Stream<QuerySnapshot<Map<String, dynamic>>> buildViews =
    FirebaseFirestore.instance.collection('users').snapshots();

    // Map the QuerySnapshot to a List<UserModel>
    return buildViews.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    });
  } catch (e) {
    print('Error fetching user details: $e');
    return Stream.value([]);
  }
});
