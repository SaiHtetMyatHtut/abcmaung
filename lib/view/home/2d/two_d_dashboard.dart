import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/lang/localization_service.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/view/home/2d/dashboard/bet_layout.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/abc_icon/abc_icon_icons.dart';
import 'package:logger/logger.dart';
import 'package:lucky_number_box/lucky_number_box.dart';
import 'package:display_box/display_box.dart';
import 'package:tab_bar_collection/tab_bar_collection.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class TwoDDashboard extends StatelessWidget {
  TwoDDashboard({ Key? key }) : super(key: key);
  final _lctrl = Get.put(TwoDDashboardController());
  LocalizationService _local = Get.find();
  void record()=> Get.toNamed('/twodrecord');
  void winner()=> Get.toNamed('/twodwinner');
  void close()=> Get.toNamed('/twodclose');
  void package()=> Get.toNamed('/twodpackage');
  void betButtom(){
    if(_lctrl.isLoading.isTrue){
      error('Loading','Please Wait  .  .  .');
    }else if(_lctrl.isColoseDay.isFalse){
      Get.toNamed('/twodbetting');
    }
    else{
      error('Error','Today is Colse!');
    }
  }
  @override
  Widget build(BuildContext context) {
    return BETScaffold(
      appBar: abcAppBar(title: 'Back',actions: action()),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30.0),
        child: Obx( ()=>  ListView(
          children: [
            const SizedBox(height: 50.0,),

            _lctrl.isColoseDay.isFalse?
            Column(children: [

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: LuckyNumberBox(
                    opacity: _lctrl.minute.value>989?1:_lctrl.opacity.value,
                    luckynumber: _lctrl.live.value,
                  ),
                ),
                const SizedBox(width: 17,),
                Expanded(
                  flex: 5,
                  child: DetailText(
                    firstLine: (_local.current=='English'?'Lucky Number at '.tr+'\n':'') + _lctrl.target.value +' '+
                    (_local.current=='English'?'':'Lucky Number at '.tr),
                    secondLine: 'Update at '.tr,
                    updatetime: _lctrl.updatedTime.value, 
                    date: _lctrl.currentDate.value
                  )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
              child: Text(
                'Previous Numbers'.tr,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors.darkGreen
                ),
              ),
            ),

            TwoDbox(
              opacity: _lctrl.minute.value>720?1:_lctrl.opacity.value,
              time: _lctrl.mResultTime.value,
              set: _lctrl.minute.value>720?_lctrl.mSet.value:_lctrl.set.value,
              value: _lctrl.minute.value>720?_lctrl.mValue.value:_lctrl.value.value,
              lucky: _lctrl.minute.value>720?_lctrl.mResult.value:_lctrl.live.value,
            ),
            const SizedBox(height: 12.0,),

            TwoDbox(
              // opacity: _lctrl.minute.value>990&&?1:_lctrl.opacity.value,
              opacity: _lctrl.minute.value>840&&_lctrl.minute.value<989?_lctrl.opacity.value:1,
              time: _lctrl.eResultTime.value,
              set: _lctrl.minute.value>840&&_lctrl.minute.value<989?_lctrl.set.value:_lctrl.eSet.value,
              value: _lctrl.minute.value>840&&_lctrl.minute.value<989?_lctrl.value.value:_lctrl.eValue.value,
              lucky: _lctrl.minute.value>840&&_lctrl.minute.value<989?_lctrl.live.value:_lctrl.eResult.value,
            ),
            const SizedBox(height: 12.0,),
          
            Row(children: [
              Expanded(
                child: LuckyDisplayBox(
                  opacity: _lctrl.minute>570? 1 : _lctrl.opacity.value,
                  time: _lctrl.mModernAndInternetTime.value,
                  modern: _lctrl.mModern.value,
                  internet: _lctrl.mInternet.value,
                )
              ),
              const SizedBox(width: 17,),
              Expanded(
                child: LuckyDisplayBox(
                  opacity: _lctrl.minute>840? 1 : _lctrl.opacity.value,
                  time: _lctrl.eModernAndInternetTime.value,
                  modern: _lctrl.eModern.value,
                  internet: _lctrl.eInternet.value,
                )
              ),
            ],),
            const SizedBox(height: 12.0,),
            
            ],crossAxisAlignment: CrossAxisAlignment.start,):
            
            // when close
            Container(
              width: double.infinity,
              height: 400.0,
              alignment: Alignment.center,
              child: Opacity(
                opacity: _lctrl.opacity.value,
                child: Text(
                  'Closed on\nSaturdays and Sundays!'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.darkGreen
                  ),
                ),
              ),
            ),

            FourTab(
              recordText: 'Record'.tr,
              recordIcon: AbcIcon.record,
              recordFun: record,
              winnerText: '   Winner'.tr,
              winnerIcon: AbcIcon.winner,
              winnerFun: winner,
              closeText: 'Close'.tr,
              closeIcon: AbcIcon.close,
              closeFun: close,
            ),
            const SizedBox(height: 20.0,),
          ],
        ),
      ),
      ),
      bottomNaviCallBack: betButtom,
    );
  }
}

class TwoDDashboardController extends GetxController{
  RxDouble opacity=0.0.obs;
  RxInt minute=0.obs;
  RxString target=''.obs;
  RxBool isLoading=true.obs;

  RxBool isColoseDay=false.obs;
  RxString set='-'.obs;
  RxString value='-'.obs;
  RxString live='-'.obs;
  RxString currentDate='-'.obs;
  RxString updatedTime='-'.obs;
  RxString eInternet='-'.obs;
  RxString eModern='-'.obs;
  RxString eResult='-'.obs;
  RxString eSet='-'.obs;
  RxString eValue='-'.obs;
  RxString mInternet='-'.obs;
  RxString mModern='-'.obs;
  RxString mResult='-'.obs;
  RxString mSet='-'.obs;
  RxString mValue='-'.obs;
  RxString mResultTime='-'.obs;
  RxString eResultTime='-'.obs;
  RxString mModernAndInternetTime='-'.obs;
  RxString eModernAndInternetTime='-'.obs;
  Logger log = Logger();
  @override
  void onInit() {
    getData();
    flashLight();
    super.onInit();
  }
  void getData()async{
    while(Get.currentRoute=='twoddashboard'){
      ApiService(Dio()).dashboad2D()
      .then((ans){
        set(ans.data.set==''?'-':ans.data.set);
        value(ans.data.value==''?'-':ans.data.value);
        live(ans.data.live==''?'-':ans.data.live);
        currentDate(ans.data.currentDate==''?'-':ans.data.currentDate);
        updatedTime(ans.data.updatedTime==''?'-':ans.data.updatedTime);
        eInternet(ans.data.eInternet==''?'-':ans.data.eInternet);
        eModern(ans.data.eModern==''?'-':ans.data.eModern);
        eResult(ans.data.eResult==''?'-':ans.data.eResult);
        eSet(ans.data.eSet==''?'-':ans.data.eSet);
        eValue(ans.data.eValue==''?'-':ans.data.eValue);
        mInternet(ans.data.mInternet==''?'-':ans.data.mInternet);
        mModern(ans.data.mModern==''?'-':ans.data.mModern);
        mResult(ans.data.mResult==''?'-':ans.data.mResult);
        mSet(ans.data.mSet==''?'-':ans.data.mSet);
        mValue(ans.data.mValue==''?'-':ans.data.mValue);
        // test
        isColoseDay(ans.isCloseDay);
        // isColoseDay(true);
        // test
        mResultTime(ans.time.mResult==''?'-':ans.time.mResult);
        eResultTime(ans.time.eResult==''?'-':ans.time.eResult);
        mModernAndInternetTime(ans.time.mModernAndInternet==''?'-':ans.time.mModernAndInternet);
        eModernAndInternetTime(ans.time.eModernAndInternet==''?'-':ans.time.eModernAndInternet);
      
        if(updatedTime.value!='-'){
          int hour = int.parse(updatedTime.value.substring(0,2));
          int min = int.parse(updatedTime.value.substring(3,5))+(hour*60);
          minute(min);
        }
        target(
          mResult.value=='-'&&eResult.value=='-'?mResultTime.value:
          mResult.value!='-'&&eResult.value=='-'?
          eResultTime.value:eResultTime.value
        );
        isLoading(false);
      });
      await sleep(5000);
    }
  }
  void flashLight()async{
    int duration = 500;
    await sleep(3000);
    while (Get.currentRoute=='twoddashboard') {
      double split = 0;
      double _opacity = 0.0;
      await sleep(2000);
      while(split<duration){
        await sleep(duration~/10);
        _opacity+=0.1;
        split += (duration/10);
        opacity(_opacity);
      }
    }
  }
  Future sleep(int sleep)=> Future.delayed(Duration(milliseconds: sleep));
}