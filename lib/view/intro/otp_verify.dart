import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:abc_maung/lang/localization_service.dart';

// ignore: must_be_immutable
class OtpVerigy extends StatelessWidget {
  OtpVerigy({Key? key}) : super(key: key);
  final Controller _ctrl = Get.find();
  final VerifyController _vctrl = Get.put(VerifyController());
  final TextEditingController _otpControl = TextEditingController();
  final log = Logger();
  final _argu = Get.arguments;
  late int requestId;
  late String userPhone;
  late String userName;
  late String userPassword;
  complete(String v){
    _vctrl.otpCode(v);
    log.i(requestId);
    log.i(int.parse(v));
    ApiService(Dio())
        // .sendOtp2(472433, 143070)
        .sendOtp2(requestId, int.parse(v))
        .then((value) {
          log.i('message: ${value.message} ,statusCode: ${value.status}');
            // Register User
            log.i('$userPhone $userName $userPassword');
            ApiService(Dio())
                .register(userPhone, userName, userPassword)
                .then((value) {
              log.i('message: ${value.message} ,statusCode: ${value.status}');
              _ctrl.setFirstTime(false);
              Get.offAllNamed('/login',arguments: {
                'userPhone':userPhone,
              });
            }).catchError((Object obj) {
              switch (obj.runtimeType) {
                case DioError:
                  ErrorResponse errorResponse = ErrorResponse(obj: obj);
                  Get.snackbar('ERROR ${errorResponse.statusCode}', errorResponse.codeMsg,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 5));

                  break;
                default:
              }
            });

            // Register User
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          Get.snackbar('ERROR ${errorResponse.statusCode}', errorResponse.codeMsg,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5));
          _otpControl.text='';
          break;
        default:
      }
    });
  }
  resend(){
    ApiService(Dio())
    .sendOtp1(userPhone)
    .then((value){
      log.i('status: ${value.status}');
      log.i('reqid: ${value.requestId}');
      log.i('message: ${value.message}');
      Get.offNamed('/otp',arguments: {
        'requestId':value.requestId,
        'userPhone':userPhone,
        'userName':userName,
        'userPassword':userPassword
      });
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          Get.snackbar('ERROR ${errorResponse.statusCode}', errorResponse.codeMsg,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5));
          log.e(errorResponse.codeMsg);
          _otpControl.text='';
          break;
        default:
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_argu!=null){
      requestId = _argu['requestId'];
      userPhone = _argu['userPhone'];
      userName = _argu['userName'];
      userPassword = _argu['userPassword'];
    }else{
      requestId = 0;
      userPhone = '';
      userName = '';
      userPassword = '';
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 26,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.greenAccent),
          backgroundColor: ThemeColors.white,
          elevation: 0,
          title: Row(
            children: [
              clicktoback(),
              Text(
                'OTP Verification'.tr,
                style: GoogleFonts.poppins(
                    color: ThemeColors.lightGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 30, top: 26, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              firstline(),
              const SizedBox(height: 10),
              Obx( ()=>secondline(time: _vctrl.timeLeft.value ) ),
              const SizedBox(height: 30),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ass(context)),
                  // child: Otpfield()),
              const SizedBox(height: 10),
              Obx(
                  ()=>Align(
                    alignment: Alignment.center,
                    child: resendotp(),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget ass(BuildContext context) =>PinCodeTextField(
      controller: _otpControl,
      autoDismissKeyboard: true,
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.dark,
      appContext: context,
      length: 6,
      obscureText: true,
      // obscuringCharacter: '●',//⚫ ⬤
      obscuringCharacter: '⬤',
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          selectedColor: ThemeColors.white,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 45, // from 35
          fieldWidth: 45,
          activeFillColor: Colors.black26,
          selectedFillColor: Colors.black26,
          inactiveFillColor: Colors.black26,
          activeColor: Colors.black12,
          inactiveColor: ThemeColors.white
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: ThemeColors.white,
      cursorColor: Colors.transparent,
      enableActiveFill: true,
      //errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (v) {
        complete(v);
      },
      onChanged: (value) {
        // log.i(value);
        // setState(() {

        // });
      },
    );
  Widget resendotp() => GestureDetector(
    onTap: ()=> resend(),
    child: Text('Resend OTP'.tr,
        style: GoogleFonts.poppins(fontSize: 14,
            color: _vctrl.isTimeout.isTrue?ThemeColors.lightGreen:Colors.grey,
        )
    ),
  );
}

Widget clicktoback() => GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 90, left: 35),
        child: Icon(
          Icons.arrow_back_sharp,
          color: ThemeColors.lightGreen,
        ),
      ),
    );

Widget firstline() => Text(
      'Please Enter \nOTP Verfication'.tr,
      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
    );
    final LocalizationService _local = Get.find();
Widget secondline({required int time}) => Row(children: [
  _local.current=='English'?
  Text(
    'Resend OTP Again in '.tr, //TODO: change time data real time
    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
  ):Container(),
  Text(
    timeFormat(time), //TODO: change time data real time
    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.red),
  ),
  _local.current!='English'?
  Text(
    'Resend OTP Again in '.tr, //TODO: change time data real time
    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
  ):Container(),
],);
String timeFormat(int time){
  String min = (time/60).floor().toString();
  String sec = (time%60).toString();
  return '${min.length>1? min:'0$min'}:${sec.length>1?sec:'0$sec'}';
}

class VerifyController extends GetxController{
  RxString otpCode = ''.obs;
  RxInt timeLeft = 120.obs;
  RxBool isTimeout = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    count();
  }
  @override
  void onClose() {
    timeLeft(0);
    super.onClose();
  }

  void count()async{
    print(timeLeft);
    await Future.delayed(const Duration(seconds: 3));
    while (timeLeft.value>0){
      await Future.delayed(const Duration(seconds: 1),
          (){
            timeLeft-=1;
            // print(timeLeft);
          }
      );
    }
    if(timeLeft.value==0){
      isTimeout(true);
    }
  }
}