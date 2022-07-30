import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:dio/dio.dart';

class TabBarController extends GetxController {
  final Controller _ctrl = Get.find();
  late TabController tabController;
  TabBarController({required this.tabController});
  RxInt index = 0.obs;
  setIndex(index) {
    this.index.value = index;
    // if(index>0) {
    //   balance();
    // }
    update();
  }
  @override
  void onInit() {
    balance();
    super.onInit();
  }
  void balance()async{
    while(Get.currentRoute=='/home'){
      ApiService(Dio())
      .userData(_ctrl.userId)
      .then((value){
        _ctrl.setMainBalance(value.balanceData.mainBalance);
        _ctrl.setGameBalance(value.balanceData.gameBalance);
      }).onError((error, stackTrace) => null);
      await Future.delayed(Duration(milliseconds: 5000));
    }
  }
}
