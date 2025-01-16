import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class TextUnderline extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color? color;
  final double? fontSize;
  const TextUnderline({super.key, required this.text, required this.onTap, this.color, this.fontSize});

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
      child: Text(widget.text, style: TextStyle(decoration: isUnderline ? TextDecoration.underline : TextDecoration.none, decorationColor: widget.color ?? Colors.black, fontSize: widget.fontSize ?? 14.0, color: widget.color ?? Colors.black, fontFamily: '')));
  }
}