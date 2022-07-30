import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Controller _ctrl = Get.find();
AppBar abcAppBar({
  required String title, 
  required List<Widget> actions,
})=>AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: 26,
    titleSpacing: 0,
    iconTheme: const IconThemeData(color: Colors.greenAccent),
    backgroundColor: ThemeColors.white,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back_sharp),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: ThemeColors.lightGreen,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Row(children: actions,mainAxisAlignment: MainAxisAlignment.spaceBetween,)
        ],
      ),
    ),
  );

List<Widget> action()=>[
  Obx( ()=>
  Text(
    _ctrl.mainBalance.value.toString() + ' MMK'.tr,
    style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ThemeColors.darkGreen
    )
  )
  ),
  IconButton(
    onPressed: (){
      Get.toNamed('/help');
      // _ctrl.setBalance(_ctrl.balance.value+1);
    },
    icon: Icon(Icons.info,color: ThemeColors.lightGreen)
  )
];