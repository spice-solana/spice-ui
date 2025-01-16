import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class AppBarMenuItem extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool isActive;
  const AppBarMenuItem({super.key, required this.onTap, required this.title, required this.isActive});

  @override
  State<AppBarMenuItem> createState() => _AppBarMenuItemState();
}

class _AppBarMenuItemState extends State<AppBarMenuItem> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
        onTap: widget.onTap,
        onHover: (value) {
          isHover = value;
          setState(() {});
        },
        child: Text(widget.title,
            style: TextStyle(
                fontSize: 15.0, color: isHover ? Theme.of(context).colorScheme.onPrimary : widget.isActive ? null : Colors.grey.withOpacity(0.5))));
  }
}
