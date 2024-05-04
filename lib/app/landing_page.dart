import 'package:call_app/app/call_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// final phoneNumberProvider = Provider.autoDispose<String>((ref) {
//   final authService = ref.watch(authServiceProvider);
//   return authService.formattedPhoneNumber;
// });
TextEditingController callIdController = TextEditingController();

TextEditingController userIdController = TextEditingController();

TextEditingController userNameController = TextEditingController();

class LandingPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final phoneNumber = ref.watch(phoneNumberProvider);
    //print("successfully signed in with phone ${phoneNumber}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo call'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: callIdController,
                decoration: const InputDecoration(
                  hintText: "please enter call id",
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(
                  hintText: "please enter useriD",
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  hintText: "please enter usrname",
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CallPage(
                            callID: callIdController.text,
                            userID: userIdController.text,
                            username: userNameController.text,
                          )));
                },
                child: Text("join the call"))
          ],
        ),
      ),
    );
  }
}