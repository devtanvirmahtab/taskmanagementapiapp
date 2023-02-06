
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/confirm_pass_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/forgetpass_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/pin_verify_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/login_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/signup_screen.dart';
import 'package:taskmanagementapiapp/screens/home_page.dart';
import 'package:taskmanagementapiapp/screens/home_screen.dart';
import 'package:taskmanagementapiapp/screens/splash/splash_screen.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());
      case RoutesName.mainhome:
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpScreen());
      case RoutesName.forgetPassScreen:
        return MaterialPageRoute(builder: (BuildContext context) => ForgetPasswordScreen());
      case RoutesName.pinverifyScreen:
        return MaterialPageRoute(builder: (BuildContext context) => PinVerifyScreen());
      case RoutesName.confirmScreen:
        return MaterialPageRoute(builder: (BuildContext context) => ConfirmPassScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(child: Text("No route Defined"))
        );
        });
    }
  }
}