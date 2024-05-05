import 'package:call_app/Utils/button.dart';
import 'package:call_app/app/home_page.dart';
import 'package:call_app/login_screen1/auth_services.dart';
import 'package:call_app/login_screen1/phone_page.dart';
import 'package:call_app/routing.dart';
import 'package:flutter/material.dart';


class SignInLandingPage extends StatelessWidget {
  Future<void> _openSignup(BuildContext context) async {
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
              Image.asset(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              "assets/splash_screen.jpg",
              // width: 300,
              //   height: 300,
            ),),
            SizedBox(height: 50),
            Text(
              "Welcome to this Call App ",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: "Sign in with phone number",
                onPressed: () => _openSignup(context),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
