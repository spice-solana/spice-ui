import 'package:flutter/material.dart';

class BlinkingLiveIndicator extends StatefulWidget {
  const BlinkingLiveIndicator({super.key});

  @override
  BlinkingLiveIndicatorState createState() => BlinkingLiveIndicatorState();
}

class BlinkingLiveIndicatorState extends State<BlinkingLiveIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); 

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 16.0),
        const Text(
          'Live',
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}