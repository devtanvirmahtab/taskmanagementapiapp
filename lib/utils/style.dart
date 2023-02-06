import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle titleTextStyle(BuildContext context) =>  TextStyle(
    color: Theme.of(context).primaryColor,
    fontSize: 35,
    fontWeight: FontWeight.bold
);

TextStyle subTextStyle(BuildContext context) => TextStyle(
    color: Theme.of(context).primaryColor,
    fontSize: 18
);

TextStyle textButtonStyle (BuildContext context) => TextStyle(
    color: Theme.of(context).primaryColor,
    fontSize: 16
);