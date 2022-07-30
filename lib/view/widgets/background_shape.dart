import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2173913);
    path_0.cubicTo(0, size.height * 0.09732913, size.width * 0.02529466, 0,
        size.width * 0.05649718, 0);
    path_0.lineTo(size.width * 0.9435028, 0);
    path_0.cubicTo(size.width * 0.9747062, 0, size.width,
        size.height * 0.09732935, size.width, size.height * 0.2173913);
    path_0.lineTo(size.width, size.height * 0.7688804);
    path_0.cubicTo(
        size.width,
        size.height * 0.9418326,
        size.width * 0.9493701,
        size.height * 1.049949,
        size.width * 0.9098249,
        size.height * 0.9677370);
    path_0.cubicTo(
        size.width * 0.8372062,
        size.height * 0.8167663,
        size.width * 0.7341441,
        size.height * 0.6332141,
        size.width * 0.6525424,
        size.height * 0.6086957);
    path_0.cubicTo(
        size.width * 0.5414689,
        size.height * 0.5753228,
        size.width * 0.4751525,
        size.height * 0.8785196,
        size.width * 0.3644068,
        size.height * 0.8217391);
    path_0.cubicTo(
        size.width * 0.2778150,
        size.height * 0.7773424,
        size.width * 0.2410432,
        size.height * 0.4060283,
        size.width * 0.1553672,
        size.height * 0.4869565);
    path_0.cubicTo(
        size.width * 0.1435325,
        size.height * 0.4981359,
        size.width * 0.1311972,
        size.height * 0.5197543,
        size.width * 0.1188794,
        size.height * 0.5479120);
    path_0.cubicTo(size.width * 0.07276864, size.height * 0.6533163, 0,
        size.height * 0.5524630, 0, size.height * 0.3460891);
    path_0.lineTo(0, size.height * 0.2173913);
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
