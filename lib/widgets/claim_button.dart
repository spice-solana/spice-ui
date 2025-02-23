import 'package:flutter/material.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class ClaimButton extends StatefulWidget {
  final Function() onTap;
  const ClaimButton({super.key, required this.onTap});

  @override
  State<ClaimButton> createState() => _ClaimButtonState();
}

class _ClaimButtonState extends State<ClaimButton> {
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
        height: 30.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: Theme.of(context).hintColor),
          color: isHover ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.5) : null
        ),
        child: const Text("Claim", style: TextStyle(fontSize: 14.0)),
      ),
    );
  }
}