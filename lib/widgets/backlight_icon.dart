import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightIcon extends StatefulWidget {
    final IconData iconData;
  final double iconSize;
  final Function() onTap;
  const BacklightIcon({super.key, required this.iconData, required this.iconSize, required this.onTap});

  @override
  State<BacklightIcon> createState() => _BacklightIconState();
}

class _BacklightIconState extends State<BacklightIcon> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      onTap: widget.onTap,
      child: Icon(widget.iconData, size: widget.iconSize, color: isHover ? Theme.of(context).colorScheme.onPrimary : null));
  }
}
