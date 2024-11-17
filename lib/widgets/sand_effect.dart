import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SandEffect extends StatefulWidget {
  final double width;
  final double height; 

  const SandEffect({
    super.key,
    this.width = 500.0,
    this.height = 100.0, 
  });

  @override
  SandEffectState createState() => SandEffectState();
}

class SandEffectState extends State<SandEffect> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    particles = List.generate(300, (index) {
      return Particle(
        position: Offset(
          Random().nextDouble() * widget.width,
          Random().nextDouble() * widget.height, 
        ),
        width: widget.width,
        velocity: Offset(0, Random().nextDouble() * 3 + 1),
      );
    });

    _controller.addListener(() {
      setState(() {
        for (var particle in particles) {
          particle.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: SandPainter(particles),
    );
  }
}

class SandPainter extends CustomPainter {
  final List<Particle> particles;

  SandPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    var box = Hive.box('appBox');
    var darkTheme = box.get('themeKey') ?? true;
    final Paint paint = Paint()
      ..color = darkTheme ? Colors.amber.withOpacity(0.5) : Colors.black
      ..style = PaintingStyle.fill;

    // Рисуем все частицы
    for (var particle in particles) {
      canvas.drawCircle(particle.position, darkTheme ? 0.1 : 0.4, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double width;

  Particle({required this.position, required this.velocity, required this.width});

  void update() {
    position = position.translate(velocity.dx, velocity.dy);
    
    if (position.dy > 600) {
      position = Offset(Random().nextDouble() * width, 0);
    }
  }
}
