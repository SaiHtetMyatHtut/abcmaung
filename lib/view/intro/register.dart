import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/widgets/load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:abc_maung/lang/localization_service.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  // final Controller _ctrl = Get.find();
  LocalizationService _local = Get.find();
  final RegController regController = RegController();
  final logger = Logger();
  double phHeight=0.0;
  String tempKey = '';
  // Text Controller
  final _fullName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  // Text Controller
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  void register() {
    regController.isLoading(true);
    Load();
    // Validating
    bool validate = false;
    String fullName = _fullName.text;
    String countryCode = regController.countryCode.string;
    String phoneNumber = _phoneNumber.text;
    String password = _password.text;
    // for fullName
    if (fullName.isEmpty) {
      regController.fullNameErrorText.value = 'Please enter a username';
      regController.isFullNameValidate(true);
      validate = true;
    } else if (fullName.length < 8) {
      regController.fullNameErrorText.value = 'username minimum length 8';
      regController.isFullNameValidate(true);
      validate = true;
    } else {
      regController.isFullNameValidate(false);
    }
    // for phoneNumber
    if (phoneNumber.isEmpty) {
      regController.phoneNumberErrorText.value = 'Please enter phone number';
      regController.isPhoneNumberValidate(true);
      validate = true;
    } else {
      regController.isPhoneNumberValidate(false);
    }
    // for password
    if (password.isEmpty) {
      regController.passwordErrorText.value = 'Enter a password';
      regController.isPasswordValidate(true);
      validate = true;
    } else if (password.length < 8) {
      regController.passwordErrorText.value = 'password minimum length 8';
      regController.isPasswordValidate(true);
      validate = true;
    } else {
      regController.isPasswordValidate(false);
    }

    if (!validate) {
      phoneNumber = countryCode + (phoneNumber[0]=='0'?phoneNumber.substring(1):phoneNumber);
      ApiService(Dio())
      .checkPhone(phoneNumber)
      .then((value) {
        logger.i('status: ${value.status} this phone number is ready to register');
        // Send OTP code
        ApiService(Dio())
        .sendOtp1(phoneNumber)
        .then((value){
          logger.i('status: ${value.status}');
          logger.i('reqid: ${value.requestId}');
          logger.i('message: ${value.message}');
          Get.toNamed('/otp',arguments: {
            'requestId':value.requestId,
            'userPhone':phoneNumber,
            'userName':fullName,
            'userPassword':password
          });
        })
        .catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
              final res = (obj as DioError).response;
              if (res != null) {
                if (res.data != null) {
                  String message = res.data["message"];
                  int status = res.data["status"];
                  if (status==1){
                    regController.phoneNumberErrorText.value = 'number already exists';
                    regController.isPhoneNumberValidate(true);
                  }
                  Get.back();
                  regController.isLoading(false);
                  Get.snackbar('ERROR $status', message,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 5));
                  logger.e('message -> $message ,statusCode -> $status');
                } else {
                  Get.back();
                  regController.isLoading(false);
                  logger.i('SEVER RESPONSE DATA IS NULL');
                }
              } else {
                Get.back();
                regController.isLoading(false);
                logger.i('SEVER RESPONSE NULL');
              }
              Get.back();
              regController.isLoading(false);
              break;
            default:
          }
        });
        // Send OTP code
        regController.isLoading(false);
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
            regController.isLoading(false);
            break;
          default:
        }
      });
    }else{
      Get.back();
      regController.isLoading(false);
    }
  }

  void loginPage() => Get.offNamed('/login');

  @override
  Widget build(BuildContext context) {
    phHeight=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color.fromRGBO(46, 204, 113, 1),
          body: ListView(
            children: [
              Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Container(
                    alignment: Alignment.centerRight,
                    child: DropdownButton(
                      underline: Container(),
                      // icon: const Icon(Icons.arrow_drop_down),
                      iconEnabledColor: Colors.white,
                      value: _local.current,
                      dropdownColor: ThemeColors.lightGreen,
                      items: LocalizationService.langs.map((String lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(
                            lang,
                            style: abcStyle(14, FontWeight.normal, ThemeColors.white),
                          ));
                      }).toList(),
                      onChanged: (value) {                
                        _local.changeLocale(value.toString());
                      },
                    ),
                  ),
              )
            ],mainAxisAlignment: MainAxisAlignment.end,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Align(
                        child: Text(
                          'Sign Up'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: [
                        Text(
                          'Full Name'.tr,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Obx(() => TextFormField(
                                  controller: _fullName,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18.0),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintStyle: GoogleFonts.poppins(
                                          color: Colors.white54),
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Your Name'.tr,
                                      errorText: regController
                                              .isFullNameValidate.isTrue
                                          ? regController
                                              .fullNameErrorText.string
                                          : null,
                                      errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.red)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.white)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0,
                                              color: Colors.white))),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Phone Number'.tr,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: _local.current=='မြန်မာ'? 15.0: 0.0),
                            child: Obx(() => phoneNum()),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                            flex: 5,
                            child: Obx(() => TextFormField(
                                  controller: _phoneNumber,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      hintStyle: GoogleFonts.poppins(
                                          color: Colors.white54),
                                      hintText: 'Enter Phone Number'.tr,
                                      errorText: regController
                                              .isPhoneNumberValidate.isTrue
                                          ? regController
                                              .phoneNumberErrorText.string
                                          : null,
                                      errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.red)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.white)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0,
                                              color: Colors.white))),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Password'.tr,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Obx(() => TextFormField(
                                  controller: _password,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: regController.obscureText.isTrue,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                      hintStyle: GoogleFonts.poppins(
                                          color: Colors.white54, fontSize: 18),
                                      // labelText: 'Full Name',
                                      hintText: 'Enter New Password'.tr,
                                      errorText: regController
                                              .isPasswordValidate.isTrue
                                          ? regController
                                              .passwordErrorText.string
                                          : null,
                                      errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.red)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.white)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.0, color: Colors.white)),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          regController.obscureText.isTrue
                                              ? regController.obscureText(false)
                                              : regController.obscureText(true);
                                        },
                                        icon: Icon(
                                          regController.obscureText.isTrue
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color:
                                              regController.obscureText.isTrue
                                                  ? Colors.white54
                                                  : Colors.white,
                                        ), //Icons.remove_red_eye_outlined
                                      )),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      ()=>Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: regController.isLoading.isTrue?Colors.grey:Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () => regController.isLoading.isTrue?
                          print('is Loading')
                          :register(),
                        child: Text(
                          'Continue'.tr,
                          style: GoogleFonts.poppins(
                            color: regController.isLoading.isTrue?Colors.white:Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => loginPage(),
                        child: Row(children: [
                          Text(
                            'Click '.tr,
                            // style: GoogleFonts.poppins(),
                            style: const TextStyle(fontFamily: 'Poppins',color: Colors.white54),
                          ),
                          Text(
                            'here'.tr,
                            // style: GoogleFonts.poppins(),
                            style: const TextStyle(fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
                          ),
                          Text(
                            ' already have an account?'.tr,
                            // style: GoogleFonts.poppins(),
                            style: const TextStyle(fontFamily: 'Poppins',color: Colors.white54),
                          ),
                        ],mainAxisAlignment: MainAxisAlignment.center,)
                    )
                  ],
                ),
              ),
            ],
            // mainAxisAlignment: MainAxisAlignment.center,
          )),
    );
  }

  // dropdown phone number
  Widget phoneNum() => DropdownButtonFormField<String>(
        elevation: 0,
        dropdownColor: const Color.fromRGBO(46, 204, 113, 1),
        isExpanded: true,
        iconEnabledColor: Colors.white,
        focusColor: Colors.green,
        onChanged: (String? value) {
          regController.setFlagUrl(value!);
        },
        hint: Text(
          '  MM'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefix: Visibility(
              visible: regController.isNotSelect.isTrue,
              child: SizedBox(
                height: 15.0,
                child: Image.asset(
                  regController.flagUrl.value,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.red)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.white)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.white))),
        items: [
          DropdownMenuItem(
            value: '+95',
            child: Row(
              children: [
                SizedBox(
                  height: 15.0,
                  child: Image.asset(
                    'assets/flag/mm.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text('  MM'.tr),
              ],
            ),
          ),
          DropdownMenuItem(
            value: '+66',
            child: Row(
              children: [
                SizedBox(
                  height: 15.0,
                  child: Image.asset(
                    'assets/flag/th.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text('  TH'.tr)
              ],
            ),
          ),
        ],
      );
}

class RegController extends GetxController {
  // Validate
  var isFullNameValidate = false.obs;
  var isPhoneNumberValidate = false.obs;
  var isPasswordValidate = false.obs;
  var fullNameErrorText = ''.obs;
  var phoneNumberErrorText = ''.obs;
  var passwordErrorText = ''.obs;
  // Validate
  RxBool isLoading = false.obs;
  // Show/Hide Password
  var obscureText = true.obs;

  // Show/Hide Password

  // Country code
  var countryCode = '+95'.obs;
  var flagUrl = 'assets/flag/mm.png'.obs;
  var isNotSelect = true.obs;
  setFlagUrl(String value) {
    countryCode(value);
    if (value == '+95') {
      isNotSelect(false);
      flagUrl('assets/flag/mm.png');
    } else if (value == '+66') {
      isNotSelect(false);
      flagUrl('assets/flag/th.png');
    }
    update();
  }
  // Country code
}
