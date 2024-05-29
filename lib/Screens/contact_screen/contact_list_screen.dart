

import 'package:call_app/Utils/drawer.dart';
import 'package:call_app/Utils/user_card.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:call_app/services/user_provider.dart';
import 'package:call_app/services/zego_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListScreen extends ConsumerWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListAsyncValue = ref.watch(allUserProvider);
    final AsyncValue<UserModel?> userDetails = ref.watch(userDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        foregroundColor: Colors.black,
        elevation: 10,
        title: const Text('Contact List'),
      ),
      body:
      userListAsyncValue.when(
        data: (userList) {
          return userDetails.when(
              data: (userOne){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                //return UserCard(userData: user);

                if (user.username != userOne!.username) {
                  return UserCard(userData: user);
                }
                return const SizedBox.shrink();
              },
            );
              },
            loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error userDetail: $error')),
          // return ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: userList.length,
          //   itemBuilder: (context, index) {
          //     final user = userList[index];
          //     //return UserCard(userData: user);
          //
          //     if (user.username != userDetails.value!.username) {
          //       return UserCard(userData: user);
          //     }
          //     return const SizedBox.shrink();
          //   },
          // );
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error Among Users Data: $error')),
      ),
    );
  }
}
// class ContactListScreen extends StatefulWidget {
//   const ContactListScreen({super.key});
//
//   @override
//   State<ContactListScreen> createState() => _ContactListScreenState();
// }
// //late Future<UserModel?> userFuture;
// UserModel? user  = FirebaseServices.currentUser;
// class _ContactListScreenState extends State<ContactListScreen> {
//   @override
//   void initState(){
//     super.initState();
//     print("user ${user!.name}");
//  //userFuture = FirebaseServices().getUserData();
//   //print ("userName ${userFuture.then((value) => value!.username)}");
//  //  var userid= FirebaseServices.currentUser!.username;
//  // var name  = FirebaseServices.currentUser!.username;
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.green[200],
//           foregroundColor: Colors.black,
//           elevation: 10,
//         title: const Text('Contact List',),
//       ),
//       body:
//       ( user != null) ?
//       SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(user!.name),
//             StreamBuilder(
//                 stream: FirebaseServices.buildViews,
//                 builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else if (!snapshot.hasData || snapshot.data == null) {
//                   return const Center(
//                     child: Text('No data'),
//                   );
//                 } else {
//                   final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
//                   if (docs == null || docs.isEmpty) {
//                     return const Text('No Doc data');
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: docs.length,
//                     itemBuilder: (context, index) {
//                       print("FirebaseServices.currentUser!.name: ${FirebaseServices.currentUser!.name}");
//
//                       final model = UserModel.fromJson(docs[index].data() as Map<String, dynamic>,);
//                       if (model.username != FirebaseServices.currentUser!.username) {
//                         return UserCard(userData: model);
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   );
//
//                 }
//               }
//             )
//           ],
//         ),
//       )
//           : CircularProgressIndicator()
//     );
//   }
// }
