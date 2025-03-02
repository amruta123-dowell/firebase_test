import 'package:flutter/material.dart';

// class NavigatorService {
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   static Future<dynamic> pushNamed(String routeName,
//       {dynamic arguments}) async {
//     return navigatorKey.currentState
//         ?.pushNamed(routeName, arguments: arguments);
//   }

//   static void goBack() {
//     return navigatorKey.currentState?.pop();
//   }

//   static Future<dynamic> pushNamedAndRemoveUntil(String routeName,
//       {bool routePredicate = false, dynamic arguments}) async {
//     return navigatorKey.currentState?.pushNamedAndRemoveUntil(
//         routeName, (route) => false,
//         arguments: arguments);
//   }

//   static Future<dynamic> popAndPushNamed(String routeName,
//       {dynamic arguments}) async {
//     return navigatorKey.currentState
//         ?.popAndPushNamed(routeName, arguments: arguments);
//   }

//   static Future<dynamic> popUntil() async {
//     return navigatorKey.currentState?.popUntil((route) => route is PageRoute);
//   }

//   static Future<dynamic> popRoute() async {
//     return Navigator.of(navigatorKey.currentState!.context, rootNavigator: true)
//         .pop();
//   }

//   static Future<bool> maybePop() async {
//     return Navigator.of(NavigatorService.navigatorKey.currentContext!)
//         .maybePop();
//   }
// }

class NavigatorClass {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? pushNamed(String routeName, {dynamic arg}) async {
    return navigatorKey.currentState
        ?.pushNamed<Object?>(routeName, arguments: arg);
  }

  void pop() {
    return navigatorKey.currentState?.pop();
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {bool routePredicate = false, dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  Future<dynamic> popAndPushNamed(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);
  }
}
