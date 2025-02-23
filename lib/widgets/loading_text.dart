import 'dart:async';
import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key});

  @override
  LoadingTextState createState() => LoadingTextState();
}

class LoadingTextState extends State<LoadingText> {
  int _dotIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startDotAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _dotIndex = (_dotIndex + 1) % 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Loading'),
        for (int i = 0; i < 3; i++)
          AnimatedOpacity(
            opacity: _dotIndex == i ? 1.0 : 0.1,
            duration: const Duration(milliseconds: 250),
            child: const Text('.', style: TextStyle()),
          ),
      ],
    );
  }
}
