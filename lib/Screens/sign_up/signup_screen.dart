import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 // Import the UserModel class

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  // Optional field
  bool ? _passwordVisible;
  bool ? _passwordVisible1;
  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible1 = false;
    super.initState();
  }

  @override
  void dispose(){
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _usernameController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }


  Future signUp() async {
    if(passwordConfirmed()){
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
  );

     String uid = credential.user!.uid;

  // add user detail
  UserModel user = UserModel(
    name: _nameController.text.trim(),
    phoneNumber: _phoneNumberController.text.trim(),
    username: _usernameController.text.trim(),
    emailId: _emailController.text.trim(),
  );

  try {
    // Save user data to Firestore
    await _firestore.collection('users').doc(uid).set(user.toJson());
    //await _firestore.collection('users').add(user.toJson());

    // You can also add authentication code here if needed (e.g., Firebase Auth)

    // Show success message or navigate to another screen


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User registered successfully')),
    );

    print("credential in sigup sccren $credential");
    if(credential.user != null){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomHomePage())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error to navigate main screen')),
      );
    }
    //credential.user.emailVerified
    // if(await AuthService.isLoggedIn()){
    //   Navigator.pushNamed(
    //     context, '/contact_call_tabbar'
    //   );
    // }
  } catch (e) {
    // Handle errors (e.g., network issues)
    print('Error registering user: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error registering user')),
    );
  }


    }
  }


  bool passwordConfirmed(){
    if(_passwordController.text.trim() ==
    _confirmpasswordController.text.trim()){
    return true;
    } else {
  return false;
    }
  }

  void _submit() async {
    print("submitpressed");
    if(_formKey.currentState!.validate()){
      await signUp();
    }
  }

  void _submitButton() async {
    print("submitpressed");
    if(_formKey.currentState!.validate()){
      await signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'name',
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Username',
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Phone Number',
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length != 10 ||
                        !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _confirmpasswordController,
                  obscureText: !_passwordVisible1!,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1!;
                        });
                      }, icon: Icon(
                        _passwordVisible1!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Confirm Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter same password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submit,
                  //_submitForm,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
