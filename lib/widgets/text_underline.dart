import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class TextUnderline extends StatefulWidget {
  final String text;
  final Function() onTap;
  const TextUnderline({super.key, required this.text, required this.onTap});

  @override
  State<TextUnderline> createState() => _TextUnderlineState();
}

class _TextUnderlineState extends State<TextUnderline> {
  bool isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: widget.onTap,
      onHover: (p0) {
        isUnderline = p0;
        setState(() {});
      },
      child: Text(widget.text, style: TextStyle(decoration: isUnderline ? TextDecoration.underline : TextDecoration.none, decorationColor: Colors.amber.shade900, fontSize: 14.0, color: Colors.amber.shade900, fontFamily: '')));
  }
}