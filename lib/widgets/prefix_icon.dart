import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrefixIcon extends StatelessWidget {
  PrefixIcon({
    Key? key, required this.image,
  }) : super(key: key);

  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30,10,20,10),
      child: SvgPicture.asset(image,height: 20),
    );
  }
}