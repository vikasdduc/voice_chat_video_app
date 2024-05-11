import 'package:call_app/Utils/button.dart';
import 'package:call_app/app/home_page.dart';
import 'package:call_app/login_screen/auth_services.dart';
import 'package:call_app/login_screen/phone_page.dart';
import 'package:call_app/Utils/routing.dart';
import 'package:flutter/material.dart';


class SignInLandingPage extends StatelessWidget {
  Future<void> _openSignup(BuildContext context) async {
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushNamed(
            context, '/landing_home_page');
      } else {
        Navigator.pushNamed(
            context, '/login_page');
      }
    });
    // final navigator = Navigator.of(context);
    // await navigator.pushNamed(
    //   AppRoutes.loginPage
    //   //arguments: () => navigator.pop(),
    // );
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
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
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
            SizedBox(height: 50),
            Text(
              "Welcome to Call App ",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            Spacer(),
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
                  child: Text('Sign In')
              )
              ),
            SizedBox(height: 50),
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
                  child: Text('Sign Up')
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
