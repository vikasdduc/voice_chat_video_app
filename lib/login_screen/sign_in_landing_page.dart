import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/login_screen/auth_services.dart';
import 'package:call_app/login_screen/gmail_login.dart';
import 'package:call_app/login_screen/phone_page.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:flutter/material.dart';


class SignInLandingPage extends StatefulWidget {
  const SignInLandingPage({super.key});

  @override
  State<SignInLandingPage> createState() => _SignInLandingPageState();
}

class _SignInLandingPageState extends State<SignInLandingPage> {
  Future _openSignup(BuildContext context) async {
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomHomePage() ));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NumberLoginPage() ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     "Firebase Phone Auth ",
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Center(child:
            ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: Image.asset(
                'assets/hand_check.jpg',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
              ),
            const SizedBox(height: 50),
            Text(
              "Welcome to Call App ",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup_screen');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      backgroundColor: Colors.greenAccent[200],
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.bodyLarge
                  ),
                  child: const Text('Register')
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => _openSignup(context),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      backgroundColor: Colors.green[200],
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.bodyLarge
                  ),
                  child: const Text('Sign In With Phone Number')
              )
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()  => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)  => GmailLoginScreen())),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      backgroundColor: Colors.green[200],
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.bodyLarge
                  ),
                  child: const Text('Sign In With Gmail ')
              ),
            ),
            // SizedBox(height: 30),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //       onPressed: ()  => Navigator.pushNamed(context, '/bottom_home_page'),
            //       style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(20.0)),
            //           backgroundColor: Colors.amberAccent[200],
            //           foregroundColor: Colors.black,
            //           textStyle: Theme.of(context).textTheme.bodyLarge
            //       ),
            //       child: const Text('bottom bar ')
            //   ),
            // ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
