
import 'package:call_app/login_screen/otp_screen.dart';
import 'package:call_app/routing.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  var countryCode = "+91";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(countryCode),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                //controller: _controller,
                onChanged: (value){
                  phoneController.text = value;
                  print("phonevalue ${value}");
                },
              ),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                // Remove leading whitespace and format phone number
                String formattedPhoneNumber = countryCode + phoneController.text.trim();
                if (formattedPhoneNumber.length == 13) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(formattedPhoneNumber)));
                } else {
                  // Show error or prompt for correct phone number format
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter a valid phone number."),
                  ));
                }
              },

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Disabled color
                  }
                  return Colors.pinkAccent; // Regular color
                }),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Send the Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}