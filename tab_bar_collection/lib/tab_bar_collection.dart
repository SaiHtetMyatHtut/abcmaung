library tab_bar_collection;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FourTab extends StatelessWidget {
  final IconData recordIcon;
  final IconData winnerIcon;
  final IconData closeIcon;

  final String recordText;
  final String winnerText;
  final String closeText;

  final VoidCallback recordFun;
  final VoidCallback winnerFun;
  final VoidCallback closeFun;

  const FourTab({
    this.recordIcon = Icons.ac_unit_outlined,
    this.winnerIcon = Icons.window,
    this.closeIcon = Icons.ac_unit,
    required this.recordText,
    required this.winnerText,
    required this.closeText,
    required this.recordFun,
    required this.winnerFun,
    required this.closeFun,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Colors.white;
    const double height = 8;
    final style1 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 9,
    );
    return Container(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 23),
      width: 355,
      height: 90,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(11, 50, 28, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: recordFun,
              child: Column(
                children: [
                  Icon(recordIcon, color: iconColor),
                  const SizedBox(height: height),
                  Text(recordText, style: style1),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: winnerFun,
              child: Column(
                children: [
                  Icon(winnerIcon, color: iconColor),
                  const SizedBox(height: height),
                  Text(winnerText, style: style1),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: closeFun,
              child: Column(
                children: [
                  Icon(closeIcon, color: iconColor),
                  const SizedBox(height: height),
                  Text(closeText, style: style1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoTab extends StatelessWidget {
  final VoidCallback recordFun;
  final VoidCallback winnerFun;
  final IconData recordIcon;
  final IconData winnerIcon;
  final Color iconColor;
  final String recordText;
  final String winnerText;

  const TwoTab({
    Key? key,
    this.recordIcon = Icons.ac_unit,
    required this.recordText,
    required this.recordFun,
    this.winnerIcon = Icons.wallet_giftcard,
    required this.winnerText,
    required this.winnerFun,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 8;
    final style1 = GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 9,
    );
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      width: 355,
      height: 90,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(11, 50, 28, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: recordFun,
              child: Column(
                children: [
                  Icon(recordIcon, color: iconColor),
                  const SizedBox(height: height),
                  Text(recordText, style: style1),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: winnerFun,
              child: Column(
                children: [
                  Icon(winnerIcon, color: iconColor),
                  const SizedBox(height: height),
                  Text(winnerText, style: style1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
