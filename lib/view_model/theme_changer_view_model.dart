import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  bool isLight = false;
  var _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void setTheme(themeMode){
    _themeMode = themeMode;
    notifyListeners();
  }

  void iconPressed(){
    isLight = !isLight;
    if(isLight == false){
      setTheme(ThemeMode.light);
    }else{
      setTheme(ThemeMode.dark);
    }
  }

}