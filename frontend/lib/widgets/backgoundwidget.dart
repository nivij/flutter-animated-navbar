import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<MovingShape> shapes = [];

  @override
  void initState() {
    super.initState();

    // Reduced count for subtle effect
    for (int i = 0; i < 7; i++) {
      shapes.add(MovingShape.random());
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ShapePainter(shapes, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class MovingShape {
  Offset position;
  double radius;
  double speedX;
  double speedY;

  MovingShape({
    required this.position,
    required this.radius,
    required this.speedX,
    required this.speedY,
  });

  factory MovingShape.random() {
    final random = Random();
    return MovingShape(
      position: Offset(
        random.nextDouble() * 400,
        random.nextDouble() * 800,
      ),
      radius: random.nextDouble() * 30 + 10,
      speedX: random.nextDouble() * 2 - 1,
      speedY: random.nextDouble() * 2 - 1,
    );
  }

  void update(double t) {
    position = Offset(
      position.dx + speedX,
      position.dy + speedY,
    );

    if (position.dx < 0 || position.dx > 400) speedX *= -1;
    if (position.dy < 0 || position.dy > 800) speedY *= -1;
  }
}

class ShapePainter extends CustomPainter {
  final List<MovingShape> shapes;
  final double progress;

  ShapePainter(this.shapes, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke // <-- outline only
      ..strokeWidth = 1.5
      ..color = Colors.white.withOpacity(0.15); // light outline

    for (var shape in shapes) {
      shape.update(progress);
      canvas.drawCircle(shape.position, shape.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
