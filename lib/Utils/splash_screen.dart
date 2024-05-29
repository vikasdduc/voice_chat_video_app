import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/Utils/colors.dart';
import 'package:call_app/login_screen/sign_in_landing_page.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Future.delayed(const Duration(), _openSignin);
    super.initState();
  }

  void _openSignin() {
    FirebaseServices.isLoggedIn().then((value) {
      print("splash signin  value : $value");
      if (value) {
        //FirebaseServices().getUserData();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomHomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInLandingPage() ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: primaryColor,
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
