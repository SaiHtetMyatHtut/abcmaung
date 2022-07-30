import 'package:flutter/material.dart';

class NavPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.7513990,size.height);
    path_0.lineTo(size.width,0);
    path_0.lineTo(0,0);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width*0.7513990,size.height);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xff0B321C).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}