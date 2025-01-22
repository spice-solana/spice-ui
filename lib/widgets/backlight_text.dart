import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightText extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color? color;
  const BacklightText({super.key, required this.text, required this.onTap, this.color});

  @override
  State<BacklightText> createState() => _BacklightTextState();
}

class _BacklightTextState extends State<BacklightText> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      onTap: widget.onTap,
      child: Text(widget.text, style: TextStyle(color: isHover ? Theme.of(context).colorScheme.onPrimary : widget.color, fontSize: 14.0)));
  }
}
