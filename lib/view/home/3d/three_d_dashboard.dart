import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/home/2d/dashboard/bet_layout.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:dio/dio.dart';
import 'package:display_box/display_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/abc_icon/abc_icon_icons.dart';
import 'package:logger/logger.dart';
import 'package:tab_bar_collection/tab_bar_collection.dart';
// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class ThreeDDashboard extends StatelessWidget {
  ThreeDDashboard({ Key? key }) : super(key: key);
  localControl _lctrl = Get.put(localControl());
  void record()=> Get.toNamed('/threedrecord');
  void winner()=> Get.toNamed('/threedwinner');
  void betButtom()=>Get.toNamed('/threedbetting');
  
  @override
  Widget build(BuildContext context) {
    return BETScaffold(
      appBar: abcAppBar(title: 'Back',actions: action()),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30.0),
        child: ListView(
          children: [
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 3,
            //       child: ThreeDLuckyNumberBox(
            //         luckynumber: '565',
            //       )
            //     ),
            //     const SizedBox(width: 17,),
            //     Expanded(
            //       flex: 5,
            //       child: DetailText(
            //         firstLine: 'Lucky Number at'.tr,
            //         time: '12:00', 
            //         secondLine: 'Update at'.tr,
            //         updatetime: '4:30 PM', 
            //         date: '2021 13 Dec Monday'
            //       )
            //     )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
              child: Text(
                'Previous Numbers'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.darkGreen),
              ),
            ),
            Obx( ()=>
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _lctrl.preData.value.length,
              itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ThreeDBox(
                  luckynumber: _lctrl.preData.value[index]['number'],
                  time: _lctrl.preData.value[index]['date'],
                  text: 'Lucky Number of the Day'.tr,
                ),
              )
            )),
            TwoTab(
              recordText: 'Record'.tr,
              recordIcon: AbcIcon.record,
              recordFun: record,
              winnerText: '   Winner'.tr,
              winnerIcon: AbcIcon.winner,
              winnerFun: winner,
            ),
            const SizedBox(height: 20.0,),
          ],
        ),
      ),
      bottomNaviCallBack: betButtom,
    );
  }
}

class localControl extends GetxController {
  Logger logger = Logger();
  RxList preData = [].obs;
  @override
  void onInit() {
    ApiService(Dio())
    .dashboad3D()
    .then((value){
      List tmp = List<Map<String,String>>.generate(value.data.length, (i) => {
        'date':value.data[i].date,
        'number':value.data[i].number
      }
      ).toList();
      preData(tmp);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          logger.e(errorResponse.codeMsg);
          logger.d(errorResponse.html);
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
