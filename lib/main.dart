
import 'package:call_app/app/home_page.dart';
// import 'package:call_app/login_screen/login.dart';
import 'package:call_app/login_screen1/auth_services.dart';
import 'package:call_app/login_screen1/phone_page.dart';
// import 'package:call_app/routing.dart';

import 'package:call_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Phone Auth Tutorial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: CheckUserLoggedInOrNot());
  }
}

class CheckUserLoggedInOrNot extends StatefulWidget {
  const CheckUserLoggedInOrNot({super.key});

  @override
  State<CheckUserLoggedInOrNot> createState() => _CheckUserLoggedInOrNotState();
}

class _CheckUserLoggedInOrNotState extends State<CheckUserLoggedInOrNot> {
  @override
  void initState() {
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//       ProviderScope(
//           child: MyApp() )
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Voice Connect',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
//       initialRoute: AppRoutes.startupPage,
//       //home: StartupPage(),
//     );
//   }
// }
// class StartupPage extends StatefulWidget {
//   const StartupPage({Key? key}) : super(key: key);
//
//   @override
//   State<StartupPage> createState() => _StartupPageState();
// }
//
// class _StartupPageState extends State<StartupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return LoginScreen();
//   }
// }
