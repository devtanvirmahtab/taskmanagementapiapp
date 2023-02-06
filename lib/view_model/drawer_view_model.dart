import 'dart:ui';

import 'package:flutter/foundation.dart';

class DrawerViewModel with ChangeNotifier{
  double xOffset = 0;
  double xOffset2 = 0;
  double yOffset = 0;
  double yOffset2 = 0;
  double scaleFactor = 1;
  double scaleFactor2 = 1;
  bool drawerOpen = false;

  setOpenDrawer(Size size){
    xOffset = size.width * 0.65;
    xOffset2 = size.width * 0.6;
    yOffset = 150;
    yOffset2 = 180;
    scaleFactor = .65;
    scaleFactor2 = .57;
    drawerOpen = true;
    notifyListeners();
  }
  setCloseDrawer(){
    xOffset = 0;
    xOffset2 = 0;
    yOffset = 0;
    yOffset2 = 0;
    scaleFactor = 1;
    drawerOpen = false;
    notifyListeners();
  }
}