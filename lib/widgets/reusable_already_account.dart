import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/utils/style.dart';

import '../utils/colors.dart';

class ReusableAlreadyAccount extends StatelessWidget {
  const ReusableAlreadyAccount({
    Key? key, required this.buttonText, required this.onTap, required this.accountText,
  }) : super(key: key);
  final String buttonText,accountText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(accountText),
        TextButton(onPressed: onTap, child: Text(buttonText,style: textButtonStyle,))
      ],
    );
  }
}