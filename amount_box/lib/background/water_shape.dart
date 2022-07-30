import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1694915);
    path_0.cubicTo(0, size.height * 0.07588415, size.width * 0.02529466, 0,
        size.width * 0.05649718, 0);
    path_0.lineTo(size.width * 0.9435028, 0);
    path_0.cubicTo(size.width * 0.9747062, 0, size.width,
        size.height * 0.07588398, size.width, size.height * 0.1694915);
    path_0.lineTo(size.width, size.height * 0.8191042);
    path_0.cubicTo(
        size.width,
        size.height * 0.9637203,
        size.width * 0.9421412,
        size.height * 1.046864,
        size.width * 0.9025028,
        size.height * 0.9645678);
    path_0.cubicTo(
        size.width * 0.8303955,
        size.height * 0.8148653,
        size.width * 0.7314407,
        size.height * 0.6403356,
        size.width * 0.6525424,
        size.height * 0.6163331);
    path_0.cubicTo(
        size.width * 0.5414689,
        size.height * 0.5825415,
        size.width * 0.4751525,
        size.height * 0.8895424,
        size.width * 0.3644068,
        size.height * 0.8320492);
    path_0.cubicTo(
        size.width * 0.2778150,
        size.height * 0.7870958,
        size.width * 0.2410432,
        size.height * 0.4111229,
        size.width * 0.1553672,
        size.height * 0.4930661);
    path_0.cubicTo(
        size.width * 0.1474322,
        size.height * 0.5006559,
        size.width * 0.1392720,
        size.height * 0.5129975,
        size.width * 0.1310429,
        size.height * 0.5289008);
    path_0.cubicTo(size.width * 0.08297994, size.height * 0.6217864, 0,
        size.height * 0.5508271, 0, size.height * 0.3793093);
    path_0.lineTo(0, size.height * 0.1694915);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff2CC16B).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
