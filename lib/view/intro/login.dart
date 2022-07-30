import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/lang/localization_service.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/view/widgets/load.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/controller/controller.dart';

class Login extends StatelessWidget {
  //var descstyle = GoogleFonts.poppins(Color);
  Login({Key? key}) : super(key: key);
  final Controller _ctrl = Get.find();
  final LocalizationService _local = Get.find();
  final _argu = Get.arguments;
  final LoginController loginController = LoginController();
  final Logger logger = Logger();
  // Text Controller
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  // Text Controller

  void login() async{
    loginController.isLoading(true);
    Load();
    // Validating
    bool validate = false;
    String userPhone = _phoneNumber.text;
    String password = _password.text;
    // for fullName
    if (userPhone.isEmpty) {
      loginController.fullNameErrorText.value = 'Please enter a phone number';
      loginController.isFullNameValidate(true);
      validate = true;
    } else {
      loginController.isFullNameValidate(false);
    }
    // for fullName
    // for password
    if (password.isEmpty) {
      loginController.passwordErrorText.value = 'Please enter a password';
      loginController.isPasswordValidate(true);
      validate = true;
    } else {
      loginController.isPasswordValidate(false);
    }
    // for password
    if (!validate) {
      userPhone = loginController.countryCode.value + userPhone.substring(1);
      ApiService(Dio())
      .login(userPhone,password)
      .then((value) {
        logger.i('balance  :  ${value.walletData.mainBalance}');//
        logger.i('point    : ${value.walletData.point}');//
        logger.i('fullName : ${value.userData.fullName}');//
        logger.i('userId   : ${value.userData.userId}');//
        logger.i('userPhone: ${value.userData.userPhone}');//
        logger.i('messange : ${value.message}');
        logger.i('status   : ${value.status}');
        logger.i('token    : ${value.token}');//
        // set state user is already login
        _ctrl.setFirstTime(false);
        _ctrl.setLogin(true);
        _ctrl.setMainBalance(value.walletData.mainBalance);
        _ctrl.setGameBalance(value.walletData.gameBalance);
        _ctrl.setWalletId(value.walletData.walletId);
        _ctrl.setPoint(value.walletData.point);
        _ctrl.setFullName(value.userData.fullName);
        _ctrl.setUserId(value.userData.userId);
        _ctrl.setUserPhone(value.userData.userPhone);
        _ctrl.setToken(value.token);
        
        loginController.isLoading(false);
        Get.back();
        Get.offAllNamed('/');
        // set state end
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
            loginController.isLoading(false);
            break;
          default:
        }
      });
    }else{
      loginController.isLoading(false);
      Get.back();
    }
  }

  void registerPage() => Get.offNamed('/register');
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  @override
  Widget build(BuildContext context) {
    if(_argu!=null){
      String arguNum = _argu['userPhone'];
      String code = arguNum.substring(0,3);
      if(code=='+95'){
        loginController.flagUrl('assets/flag/mm.png');
        loginController.hint('  MM');
        loginController.countryCode(code);
      }else if(code=='+95'){
        loginController.flagUrl('assets/flag/th.png');
        loginController.hint('  TH');
        loginController.countryCode(code);
      }else{
        loginController.flagUrl('assets/flag/mm.png');
        loginController.hint('  MM');
        loginController.countryCode('+95');
      }
      _phoneNumber.text='0'+arguNum.substring(3);
    }
    // else{
    //   if(_phoneNumber.text!=''){
    //     loginController.flagUrl('assets/flag/mm.png');
    //     loginController.hint('  MM');
    //     _phoneNumber.text='';
    //   }
    // }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: ThemeColors.lightGreen,
        // ),
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
            const SizedBox(
              height: 80,
            ),
            Align(
                child: Text(
              'Login'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
            const SizedBox(
              height: 80,
            ),
            Container(
              // width: 355,
              // height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 47, left: 26, right: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: ThemeColors.lightGreen),
                        ),
                        Row(children: [
                          Expanded(
                            flex: 1,
                            child: Obx(() => phoneNum()),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Obx(
                                  () => TextFormField(
                                controller: _phoneNumber,
                                cursorColor: Colors.greenAccent,
                                keyboardType: TextInputType.number,
                                // textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(color: const Color.fromRGBO(46, 204, 113, 1)),
                                decoration: InputDecoration(
                                    hintText: "Enter Phone Number",
                                    hintStyle: GoogleFonts.poppins(),
                                    errorText: loginController
                                        .isFullNameValidate.isTrue
                                        ? loginController.fullNameErrorText.string
                                        : null,
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        )),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(46, 204, 113, 1),
                                        )
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: Color.fromRGBO(46, 204, 113, 1),
                                      )
                                    ),
                                ),
                              ),
                            ),
                          )
                        ],),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: ThemeColors.lightGreen),
                        ),
                        Obx(
                          () => TextFormField(
                            controller: _password,
                            obscureText: loginController.isObscure.isTrue,
                            cursorColor: Colors.greenAccent,
                            style: GoogleFonts.poppins(color: const Color.fromRGBO(46, 204, 113, 1)),
                            decoration: InputDecoration(
                                hintText: "Enter Password".tr,
                                hintStyle: GoogleFonts.poppins(fontSize: 18),
                                errorText: loginController
                                        .isPasswordValidate.isTrue
                                    ? loginController.passwordErrorText.string
                                    : null,
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.red,
                                )),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromRGBO(46, 204, 113, 1),
                                )),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color.fromRGBO(46, 204, 113, 1),
                                    )
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      loginController.isObscure.isTrue
                                          ? loginController.isObscure(false)
                                          : loginController.isObscure(true);
                                    },
                                    icon: Icon(
                                      loginController.isObscure.isTrue
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: loginController.isObscure.isTrue
                                          ? Colors.black54
                                          : const Color.fromRGBO(
                                              46, 204, 113, 1.0),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    ()=>Container(
                      margin: const EdgeInsets.only(bottom: 26),
                      width: 295,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: loginController.isLoading.isTrue?Colors.grey: const Color.fromRGBO(46, 204, 113, 1),
                      ),
                      child: TextButton(
                          onPressed: () => loginController.isLoading.isTrue?
                          logger.i('is Loading')
                          :login(),
                          
                          child: Text(
                            'Login'.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                          
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () => registerPage(),
              child: Row(children: [
                Text(
                  'Click'.tr,
                  style: GoogleFonts.poppins(
                    color: Colors.white54
                  ),
                ),
                Text(
                  'here'.tr,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),
                ),
                Text(
                  ' to Register?'.tr,
                  style: GoogleFonts.poppins(
                      color: Colors.white54
                  ),
                ),
              ],mainAxisAlignment: MainAxisAlignment.center,)
            ),
          ],
        ),
      ),
    );
  }
  // dropdown phone number
  Widget phoneNum() => DropdownButtonFormField<String>(
    elevation: 0,
    dropdownColor: Colors.white,
    isExpanded: true,
    iconEnabledColor: const Color.fromRGBO(46, 204, 113, 1),
    focusColor: Colors.green,
    onChanged: (String? value) {
      loginController.setFlagUrl(value!);
    },
    hint: Text(
      loginController.hint.value,
      // '  MM',
      style: const TextStyle(color: Color.fromRGBO(46, 204, 113, 1)),
    ),
    style: const TextStyle(color: Color.fromRGBO(46, 204, 113, 1)),
    decoration: InputDecoration(
        prefix: Visibility(
          visible: loginController.isNotSelect.isTrue,
          child: SizedBox(
            height: 15.0,
            child: Image.asset(
              loginController.flagUrl.value,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.red)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Color.fromRGBO(46, 204, 113, 1))),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Color.fromRGBO(46, 204, 113, 1)))),
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
            const Text('  MM'),
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
            const Text('  TH')
          ],
        ),
      ),
    ],
  );
}

class LoginController extends GetxController {
  // Validate
  RxBool isFullNameValidate = false.obs;
  RxBool isPasswordValidate = false.obs;
  RxString fullNameErrorText = ''.obs;
  RxString passwordErrorText = ''.obs;
  // Validate
  RxBool isLoading = false.obs;
  // Show/Hide Password
  RxBool isObscure = true.obs;
// Show/Hide Password

// Country code
  var hint = '  MM'.obs;
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
