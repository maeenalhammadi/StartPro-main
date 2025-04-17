import 'package:flutter/material.dart';
import 'package:start_pro/core/constants/images.dart';

class Logo extends StatelessWidget {
  final double? size;

  const Logo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }
}
