import 'package:flutter/material.dart';


class CustomVerticalDivider extends StatelessWidget {
  final double height;
  const CustomVerticalDivider({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 1.0,
      color: Theme.of(context).hintColor,
    );
  }
}
