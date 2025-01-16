import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightIconAndText extends StatefulWidget {
  final Function() onTap;
  final IconData iconData;
  final double? iconSize;
  final String text;
  final bool active;
  const BacklightIconAndText({super.key, required this.onTap, required this.iconData, required this.iconSize, required this.text, required this.active});

  @override
  State<BacklightIconAndText> createState() => _BacklightIconAndTextState();
}

class _BacklightIconAndTextState extends State<BacklightIconAndText> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: widget.onTap,
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      child: Row(
          children: [
            Icon(
              widget.iconData,
              size: widget.iconSize ?? 16.0,
              color: isHover ? Theme.of(context).colorScheme.onPrimary : widget.active ? null : Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 15.0,
                color: isHover ? Theme.of(context).colorScheme.onPrimary : widget.active ? null : Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
    );
  }
}