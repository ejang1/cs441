import 'package:flutter/material.dart';

class Balls extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint1 = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0,0), 30, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}