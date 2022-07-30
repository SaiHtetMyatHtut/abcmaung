library lucky_number_box;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LuckyNumberBox extends StatelessWidget {
  final double width;
  final double height;
  final String luckynumber;
  final Color boxcolor;
  final double opacity;
  final double fontsize;
  final BorderRadius borderRadius;
  final FontWeight fontWeight;
  final Color textcolor;
  const LuckyNumberBox({
    this.fontsize = 48,
    this.width = 100,
    this.height = 100,
    this.opacity = 0.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.boxcolor = const Color.fromRGBO(88, 214, 141, 1),
    this.fontWeight = FontWeight.w500,
    this.textcolor = Colors.white,
    required this.luckynumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      fontSize: fontsize,
      fontWeight: FontWeight.w500,
      color: textcolor,
    );
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: boxcolor,
      ),
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Text(
            luckynumber,
            style: style1,
          ),
        ),
      ),
    );
  }
}

class ThreeDLuckyNumberBox extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;
  final Color boxcolor;
  final String luckynumber;
  final BorderRadius borderRadius;
  final double fontSize;
  const ThreeDLuckyNumberBox({
    Key? key,
    required this.luckynumber,
    this.fontSize = 48,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.width = 100,
    this.height = 100,
    this.boxcolor = const Color.fromRGBO(88, 214, 141, 1),
    this.opacity = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: boxcolor,
      ),
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Text(
            luckynumber,
            style: style1,
          ),
        ),
      ),
    );
  }
}
