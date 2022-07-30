import 'package:abc_maung/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BETScaffold extends StatelessWidget {
  VoidCallback bottomNaviCallBack;
  Widget body;
  AppBar appBar;
  BETScaffold({
    Key? key,
    required this.bottomNaviCallBack,
    required this.body,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: Container(
        height: 95.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 30),
          child: ElevatedButton(
            onPressed: bottomNaviCallBack,
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Text(
              'Bet'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}