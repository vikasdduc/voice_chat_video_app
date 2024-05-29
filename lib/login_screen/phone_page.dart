import 'package:call_app/Screens/bottom_nav_bar.dart';
import 'package:call_app/login_screen/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class NumberLoginPage extends StatefulWidget {
  const NumberLoginPage({super.key});

  @override
  State<NumberLoginPage> createState() => _NumberLoginPageState();
}

class _NumberLoginPageState extends State<NumberLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Telephony telephony = Telephony.instance;

  final TextEditingController _phoneContoller = TextEditingController();
  final TextEditingController _otpContoller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  void listenToIncomingSMS(BuildContext context) {
    print("Listening to sms.");
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          // Handle message
          print("sms received : ${message.body}");
          // verify if we are reading the correct sms or not

          if (message.body!.contains("phone-auth-15bdb")) {
            String otpCode = message.body!.substring(0, 6);
            setState(() {
              _otpContoller.text = otpCode;
              // wait for 1 sec and then press handle submit
              Future.delayed(const Duration(seconds: 1), () {
                handleSubmit(context);
              });
            });
          }
        },
        listenInBackground: false);
  }

// handle after otp is submitted
  void handleSubmit(BuildContext context) {
    if (_formKey1.currentState!.validate()) {
      AuthService.loginWithOtp(otp: _otpContoller.text).then((value) {
        if (value == "Success") {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomHomePage()));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: ClipRRect(
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome Back 👋",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    const Text("Enter your phone number to continue."),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneContoller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixText: "+91 ",
                            labelText: "Phone number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Invalid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthService.sentOtp(
                                phone: _phoneContoller.text,
                                errorStep: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Error in sending OTP",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    )),
                                nextStep: () {
                                  // start lisenting for otp
                                  listenToIncomingSMS(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                const Text("OTP Verification"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Enter 6 digit OTP"),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Form(
                                                  key: _formKey1,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: _otpContoller,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            "Enter you phone number",
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        32))),
                                                    validator: (value) {
                                                      if (value!.length != 6) {
                                                        return "Invalid OTP";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      handleSubmit(context),
                                                  child: const Text("Submit")),
                                            ],
                                          ));
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black),
                        child: const Text("Send OTP"),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
