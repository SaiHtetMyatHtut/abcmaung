import 'package:abc_maung/abc_icon/abc_icon_icons.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/view/home/2d/dashboard/bet_layout.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:bet_dashboard/bet_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Controller _ctrl = Get.find();

// ignore: must_be_immutable
class ThreeDRecord extends StatelessWidget {
  ThreeDRecord({Key? key}) : super(key: key);
  ThreeDRecordController _lctrl = Get.put(ThreeDRecordController());
  void betButtom()=>Get.toNamed('/threedbetting');

  @override
  Widget build(BuildContext context) {
    return BETScaffold(
      appBar: abcAppBar(title: 'Back',actions: []),
      body: Obx( ()=>  BetDashboard(
        iconData: AbcIcon.record,
        title: 'Records'.tr,
        tableHead: ['Date'.tr,'Number'.tr,'Status'.tr],
        // tableBody: List<List<String>>.generate(20, (index) => ['$index/12/2021','0$index','Missed']),
        // ignore: invalid_use_of_protected_member
        tableBody: _lctrl.data.value,
        message: _lctrl.message.value.tr,
      ),),
      bottomNaviCallBack: betButtom,
    );
  }
}

class ThreeDRecordController extends GetxController{
  RxString message='Please Wait  .  .  .'.obs;
  RxList data=[].obs;
  @override
  void onInit() {
    ApiService(Dio())
    .betRecord3D(_ctrl.userId)
    .then((value){
      if(value.data.isNotEmpty){
        data(
          List<List<dynamic>>.generate(value.data.length, (i) => [value.data[i].time,value.data[i].number,value.data[i].state])
        );
      }else{
        message('No information yet');
      }
    })
    .onError((error, stackTrace) => null);
    super.onInit();
  }
}

