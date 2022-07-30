import 'package:abc_maung/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
void error(String title,String body){
      Get.defaultDialog(
        title: title.tr,
        titlePadding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
             Text(body.tr),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                    primary: ThemeColors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                child: Text(
                  'close'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ]);
    }