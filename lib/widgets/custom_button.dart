import 'package:flutter/material.dart';

import '../utils/colors.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,  required this.onTap, required this.text,this.loading = false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:50,
      child: loading ?
      Container(
        decoration: BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.circular(30)
        ),
          child: const Center(child: CircularProgressIndicator(color: appWhiteColor,))) :
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: appPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
        ),
        child: Text(text),
      ),
    );
  }
}