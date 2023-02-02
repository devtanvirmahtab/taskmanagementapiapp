import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utiles{

  static void fieldFocusChange(BuildContext context,FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
      toastLength: Toast.LENGTH_LONG
    );
  }
}