
import 'package:call_app/Screens/contact_screen/contact_list_screen.dart';
import 'package:call_app/Screens/sign_up/signup_screen.dart';
import 'package:call_app/Utils/splash_screen.dart';
import 'package:call_app/login_screen/phone_page.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'Screens/bottom_nav_bar.dart';
import 'login_screen/gmail_login.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseServices.setupFirebase();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  final navigatorKey = GlobalKey<NavigatorState>();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  runApp(ProviderScope(child: MyApp(navigatorKey: navigatorKey)));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key,required this.navigatorKey,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         navigatorKey: widget.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Voice Connect',
        theme: ThemeData(
          // focusColor: Theme.of(context).focusColor.red,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        // onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        // initialRoute: AppRoutes.startupPage,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,
            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
      routes: {
        '/': (context) => SplashScreen(),
          //await AuthService.isLoggedIn() ? SignInLandingPage() : BottomHomePage() ,
        '/gmail_signin_screen' : (context) => const GmailLoginScreen(),
        '/number_login_page' : (context) => const NumberLoginPage(),
        '/signup_screen' : (context) => const SignUpScreen(),
        '/contact_list' : (context) => const ContactListScreen(),
        //'/contact_call_tabbar' : (context) => const ContactCallTabBar(userUid: '',),
        //'/landing_home_page': (context) => const ContactCallTabBar(userUid: '',),
        '/bottom_home_page': (context) => const BottomHomePage(),

    },
    );
  }
}
