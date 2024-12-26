import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class BacklightCustomIcon extends StatefulWidget {
  final String assetIcon;
  final Function() onTap;
  final double iconSize;
  const BacklightCustomIcon({super.key, required this.assetIcon, required this.onTap, required this.iconSize});

  @override
  State<BacklightCustomIcon> createState() => _BacklightCustomIconState();
}

class _BacklightCustomIconState extends State<BacklightCustomIcon> {
  bool isHover = false;

  setIcon(BuildContext context, String icon) {
    if (isHover) {
      return 'assets/icons/${icon}_hover_icon.svg';
    }

    return 'assets/icons/${icon}_${Theme.of(context).brightness == Brightness.dark ? 'white' : 'black'}_icon.svg';
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: widget.onTap,
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      child: SvgPicture.asset(setIcon(context, widget.assetIcon),
          height: widget.iconSize,
          width: widget.iconSize),
    );
  }
}
