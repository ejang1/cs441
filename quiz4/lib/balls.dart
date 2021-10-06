import 'package:flutter/material.dart';

class Balls extends CustomPainter{
  Balls({required this.radiusController, required this.position}):super(repaint: radiusController);

  final AnimationController radiusController;
  final Offset position;



  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint1 = Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radiusController.value, paint1);
  }

  @override
  bool shouldRepaint(Balls bold) => true;
}