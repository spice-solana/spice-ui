import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;


class RotorAnim extends StatelessWidget {
  final bool isPlaying;
  const RotorAnim({super.key, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      width: 220.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).hintColor, strokeAlign: 1.0)),
      child: isPlaying ? const SizedBox(
        height: 200.0,
        width: 200.0,
        child: rive.RiveAnimation.asset(
          'assets/rive/rotor.riv',
          useArtboardSize: false,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ) : Center(child: Text("disabled", style: TextStyle(color: Colors.grey.withOpacity(0.2)))),
    );
  }
}
