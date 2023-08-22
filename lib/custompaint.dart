import 'package:flutter/material.dart';

class CPShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 80);
    path.quadraticBezierTo(0, 0, size.width * 0.4, 0);
    path.lineTo(size.width * 0.6, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 80);
    path.lineTo(size.width, 250);
    path.lineTo(0, 250);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
