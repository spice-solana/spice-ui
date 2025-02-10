import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';


class DotsMenuElement extends StatefulWidget {
  final String title;
  final Function() onTap;
  const DotsMenuElement({super.key, required this.title, required this.onTap});

  @override
  State<DotsMenuElement> createState() => _DotsMenuElementState();
}

class _DotsMenuElementState extends State<DotsMenuElement> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: Container(
        width: 220.0,
        color: isHover ? Theme.of(context).hintColor : null,
        padding: const EdgeInsets.all(16.0),
        child: Text(widget.title, style: const TextStyle(fontSize: 14.0))),
    );
  }
}
