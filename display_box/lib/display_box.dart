library display_box;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoDbox extends StatelessWidget {
  final String time;
  final String set;
  final String value;
  final String lucky;
  final double opacity;
  const TwoDbox({
    this.opacity = 1,
    required this.time,
    required this.set,
    required this.value,
    required this.lucky,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
    final style2 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
    final style3 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    );
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 22),
      width: 355,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(88, 214, 141, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              time,
              style: style1,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 50, 0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Set',
                          style: style2,
                        ),
                        const SizedBox(height: 6),
                        Opacity(
                          opacity: opacity,
                          child: Text(
                            set,
                            style: style3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Value',
                          textAlign: TextAlign.center,
                          style: style2,
                        ),
                        const SizedBox(height: 6),
                        Opacity(
                          opacity: opacity,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: style3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          '2D',
                          style: style2,
                        ),
                        const SizedBox(height: 6),
                        Opacity(
                          opacity: opacity,
                          child: Text(
                            lucky,
                            style: style3,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LuckyDisplayBox extends StatelessWidget {
  final String time;
  final String modern;
  final String internet;
  final double opacity;

  const LuckyDisplayBox({
    this.opacity = 1,
    required this.time,
    required this.modern,
    required this.internet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
    final style2 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );
    return Container(
      width: 167,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(88, 214, 141, 1)),
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18, top: 14, bottom: 12),
        child: Column(
          children: [
            Row(
              children: [
                Text(time, style: style1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Modern', style: style2),
                Opacity(opacity: opacity, child: Text(modern, style: style2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Internet', style: style2),
                Opacity(opacity: opacity, child: Text(internet, style: style2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final String updatetime;
  final String date;
  const DetailText({
    required this.firstLine,
    required this.secondLine,
    required this.updatetime,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      color: const Color.fromRGBO(51, 62, 99, 1),
      fontWeight: FontWeight.w700,
      fontSize: 16,
    );
    final style2 = GoogleFonts.poppins(
      color: const Color.fromRGBO(136, 135, 156, 1),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    return SizedBox(
      width: 300,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(firstLine, style: style1,),
          Text('$secondLine $updatetime', style: style2),
          Text(date, style: style2,overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}

class ThreeDBox extends StatelessWidget {
  final String time;
  final String luckynumber;
  final double opacity;
  final String text;
  const ThreeDBox({
    Key? key,
    this.opacity = 1,
    this.text = 'Lucky Number Of The Day',
    required this.time,
    required this.luckynumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style1 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
    final style2 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 17, 26),
      width: 355,
      height: 110,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(88, 214, 141, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: style1),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: style2),
              Opacity(
                opacity: opacity,
                child: Text(luckynumber, style: style1),
              ),
            ],
          )
        ],mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
