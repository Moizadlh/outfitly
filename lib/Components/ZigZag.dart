// Zigzag Painter
import 'package:flutter/material.dart';

class ZigzagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Starting point at the bottom-left corner
    path.moveTo(0, size.height);

    // Create a zigzag pattern
    for (double i = 0; i < size.width; i += 30) {
      path.lineTo(i + 15, size.height - 20); // Zig
      path.lineTo(i + 30, size.height); // Zag
    }

    // End the path by closing it at the bottom-right corner
    path.lineTo(size.width, size.height);

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}