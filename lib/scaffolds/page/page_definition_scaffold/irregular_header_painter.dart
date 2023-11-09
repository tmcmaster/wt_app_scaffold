import 'package:flutter/material.dart';

class IrregularHeaderPainter extends CustomPainter {
  final Color color;
  const IrregularHeaderPainter({
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.6);

    // Define the cubic Bezier curve
    path.cubicTo(
      size.width * 0.4,
      size.height * 1.5,
      size.width * 0.6,
      size.height * 0.5,
      size.width,
      size.height * 0.6,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
