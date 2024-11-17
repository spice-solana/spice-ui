import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final Offset position;
  final bool openDown;
  final VoidCallback onClose;

  const CustomDropdownMenu({
    super.key,
    required this.position,
    required this.openDown,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          left: position.dx,
          top: openDown ? position.dy + 64.0 : position.dy - 150.0 - 64.0,
          child: Material(
            elevation: 8,
            color: Colors.transparent,
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Пункт 1'),
                    onTap: onClose,
                  ),
                  ListTile(
                    title: const Text('Пункт 2'),
                    onTap: onClose,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
