import 'package:flutter/cupertino.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightIconText extends StatefulWidget {
  final String text;
  final IconData iconData;
  final double iconSize;
  final Function() onTap;
  const BacklightIconText({super.key, required this.text, required this.iconData, required this.iconSize, required this.onTap});

  @override
  State<BacklightIconText> createState() => _BacklightIconTextState();
}

class _BacklightIconTextState extends State<BacklightIconText> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      onTap: widget.onTap,
      child: Row(
        children: [
          Icon(widget.iconData, size: widget.iconSize, color: isHover ? const Color(0xFF80EEFB) : null),
          const SizedBox(width: 16.0),
          Text(widget.text, style: TextStyle(color: isHover ? const Color(0xFF80EEFB) : null, fontSize: 14.0)),
        ],
      ));
  }
}
