import 'package:firebase_test/presentation/home_screen/home_screen.dart';
import 'package:firebase_test/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/widgets.dart';

import '../../presentation/sign_up_screen/sign_up_screen.dart';

class AppRoutes {
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String homeScreen = '/home_screen';

  Map<String, WidgetBuilder> get routes => {
        signInScreen: (context) => SignInScreen.builder(context),
        signUpScreen: (context) => SignUpScreen.builder(context),
        homeScreen: (context) => HomeScreen.builder(context),
      };
}
