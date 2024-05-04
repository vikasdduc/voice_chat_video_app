import 'package:call_app/app/call_page.dart';
import 'package:call_app/login_screen1/auth_services.dart';
import 'package:call_app/login_screen1/phone_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// final phoneNumberProvider = Provider.autoDispose<String>((ref) {
//   final authService = ref.watch(authServiceProvider);
//   return authService.formattedPhoneNumber;
// });
TextEditingController callIdController = TextEditingController();

TextEditingController userIdController = TextEditingController();

TextEditingController userNameController = TextEditingController();

class LandingPage extends StatefulWidget {

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
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
                child: Text("join the call")),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure you want to logout?"),
                    //content: Text("Enter 6-digit OTP"), // Add your OTP input field here if needed
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Handle logout action
                          AuthService.logout();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => LoginPage())); // Close the dialog
                        },
                        child: Text("Yes LogOut"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog without logging out
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Log Out"), // Your button child widget
            )

          ],
        ),
      ),
    );
  }
}