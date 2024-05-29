
import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GmailLoginScreen extends StatefulWidget {
  const GmailLoginScreen({super.key});

  @override
  State<GmailLoginScreen> createState() => _GmailLoginScreenState();
}
FirebaseFirestore _store  = FirebaseFirestore.instance;

class _GmailLoginScreenState extends State<GmailLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool ? _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  void dispose(){
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  // static UserModel ? _currentUser;
  // //static final  Uid = _firebaseAuth.currentUser!.uid;
  //
  // static UserModel? get currentUser {
  //   if(_currentUser == null) {
  //     throw Exception("_current userModel must not be null while using this getter");
  //   }
  //   return _currentUser;
  // }


  Future _gmailLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      print ("credential $credential");

      if(credential.user != null){
        final doc = _store.collection('users').doc(credential.user!.uid).get();
        final data = await doc.then((value) => value.data());
        print ('user data ${UserModel.fromJson(data!)}');
        print ('user data ${data}');
        // _currentUser = UserModel.fromJson(data);
        // print('_currentUser in gmail page $_currentUser');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomHomePage()));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Either gmail or password mismatch')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(child:
          ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: Image.asset(
              'assets/splash_screen.jpg',
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  hintText: 'Email',
                  fillColor: Colors.grey[200],
                  filled: true,
                  labelText: 'Email'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return 'Please enter a valid email address ';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible!,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible!;
                    });
                  }, icon: Icon(
                    _passwordVisible!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  hintText: 'Password',
                  fillColor: Colors.grey[200],
                  filled: true,
                  labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Please enter minimum 6 digit password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await FirebaseServices.login(
                  emailId: _emailController.text.trim(),
                  password: _passwordController.text.trim()
              ) ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomHomePage()))
              : ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Either gmail or password mismatch')),
              );
            },
            //_gmailLogin,
            //_submitForm,
            child: const Text('Login'),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
