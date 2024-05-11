
import 'package:call_app/login_screen/login.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class AppRoutes {
  static const startupPage = '/startup-page';
  static const loginPage = '/login-page';
  static const verifyScreen = '/login-page';
  static const signInPhonePage = '/sign-in-phone-page';
  static const signInVerificationPage = '/sign-in-verification-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.startupPage:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => StartupPage(),
      //     settings: settings,
      //   );


      case AppRoutes.loginPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginScreen(),
          settings: settings,
          fullscreenDialog: true,
        );

      // case AppRoutes.verifyScreen:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => MyVerify(),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      //
      // case AppRoutes.signInPhonePage:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => SignInPhonePageBuilder(),
      //     settings: settings,
      //   );
      //
      // case AppRoutes.signInVerificationPage:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => SignInVerificationPageBuilder(),
      //     settings: settings,
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text("Unknown route $settings.name"),
          ),
        );
    }
  }
}
