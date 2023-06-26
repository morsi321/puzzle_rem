import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:puzzle_game/view/screens/guest_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/screens/game_screen.dart';
import '../view/screens/home_screen/home_screen.dart';
import '../view/screens/login_screen.dart';
import '../view/screens/pre_game_screen.dart';
import '../view/screens/sign_up.dart';
import 'app_injection.dart';

class RouteNames {
  static const String logInRoute = '/logIn';
  static const String signUpRoute = '/signUp';
  static const String homeRoute = '/home';
  static const String guestHomeRoute = '/guestHome';
  static const String preGameRoute = '/preGame';
  static const String gameRoute = '/game';
}

class AppRouter {
  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.logInRoute:
        return _smoothTransition(const LoginScreen());
      case RouteNames.signUpRoute:
        return _smoothTransition(const SignUpScreen());
      case RouteNames.homeRoute:
        return _smoothTransition(const HomeScreen());
      case RouteNames.guestHomeRoute:
        return _smoothTransition(const GuestHomeScreen());
      case RouteNames.preGameRoute:
        final argument = settings.arguments as Image;
        return _upTransition(PreGameScreen(argument));
      case RouteNames.gameRoute:
        final argument = settings.arguments as Image;
        return _smoothTransition(GameScreen(argument));
      default:
        return null;
    }
  }

  static PageTransition _transition(Widget child, PageTransitionType type) {
    return PageTransition(child: child, type: type);
  }

  static PageTransition _smoothTransition(Widget child) {
    return _transition(child, PageTransitionType.fade);
  }

  static PageTransition _upTransition(Widget child) {
    return _transition(child, PageTransitionType.bottomToTop);
  }

  static String getInitialRoute() {
    final cachedToken = sL<SharedPreferences>().getString('token');
    if (cachedToken == null) return RouteNames.signUpRoute;
    return RouteNames.homeRoute;
  }
}
