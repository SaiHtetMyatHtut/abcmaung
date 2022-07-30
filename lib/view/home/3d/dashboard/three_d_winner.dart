import 'package:abc_maung/abc_icon/abc_icon_icons.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/home/2d/dashboard/bet_layout.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:bet_dashboard/bet_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class ThreeDWinner extends StatelessWidget {
  ThreeDWinner({Key? key}) : super(key: key);
  final _lctrl = Get.put(ThreeDWinnerController());
  void betButtom()=>Get.toNamed('/threedbetting');
  String message='Please Wait!';
  @override
  Widget build(BuildContext context) {
    return BETScaffold(
      appBar: abcAppBar(title: 'Back',actions: []),
      body: Obx( ()=> BetDashboard(
        iconData: AbcIcon.winner,
        title: 'Winner'.tr,
        tableHead: ['Winner'.tr,'Amount'.tr,'Win'.tr],
        // tableBody: List<List<String>>.generate(20, (index) => ['Sai Htet','10,000','500,000']),
        tableBody: _lctrl.data.value,
        message: _lctrl.message.value.tr,
      ),),
      bottomNaviCallBack: betButtom,
    );
  }
}

class ThreeDWinnerController extends GetxController {
  Logger logger = Logger();
  RxString message='Please Wait  .  .  .'.obs;
  RxList data=[].obs;
  @override
  void onInit() {
    ApiService(Dio())
    .betWinner3D()
    .then((value){
      if(value.data.isNotEmpty){
        data(
          List<List<dynamic>>.generate(value.data.length, (i) => [value.data[i].userName,value.data[i].bet.toString(),value.data[i].win.toString()])
        );
      }else{
        message('No information yet');
      }
    })
    .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            ErrorResponse errorResponse = ErrorResponse(obj: obj);
            logger.e(errorResponse.codeMsg);
            logger.d(errorResponse.html);
            Get.back();
            Get.snackbar('ERROR ${errorResponse.code}', errorResponse.codeMsg,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 5));
            break;
          default:
        }
      });
    super.onInit();
  }
}