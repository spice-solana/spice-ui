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
    super.dispose();
    _timer?.cancel();
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      setState(() {
        _dotIndex = (_dotIndex + 1) % 4; // Cycling from 0 to 3
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Loading${_getDot()}',
      style: const TextStyle(),
    );
  }

  String _getDot() {
    switch (_dotIndex) {
      case 0:
        return '.';
      case 1:
        return '..';
      case 2:
        return '...';
      default:
        return '';
    }
  }
}