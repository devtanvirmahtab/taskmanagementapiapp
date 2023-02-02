import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SuffixIcon extends StatelessWidget {
  SuffixIcon({Key? key, required this.visibility, required this.onTap}) : super(key: key);
  bool visibility ;

  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: visibility == true ? const Icon(Icons.visibility_off,color: appPrimaryColor,) : const Icon(Icons.visibility,color: appPrimaryColor,)
    );
  }
}