import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class Load {
  Load(){
    double cWidth=200.0;
    double cHeight=130.0;
    Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(vertical: (Get.height-cHeight)/2,horizontal: (Get.width-cWidth)/2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: RiveAnimation.asset('assets/icon/loading.riv'),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
      name: 'loading . . .',
    );
  }
}