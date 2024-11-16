import 'package:flutter/cupertino.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightText extends StatefulWidget {
  final String text;
  final Function() onTap;
  const BacklightText({super.key, required this.text, required this.onTap});

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
      child: Text(widget.text, style: TextStyle(color: isHover ? const Color(0xFF80EEFB) : null, fontSize: 14.0)));
  }
}
