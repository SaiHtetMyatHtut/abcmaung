import 'package:abc_maung/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:abc_maung/view/intro/otp_verify.dart';

class Otpfield extends StatefulWidget {
  Otpfield({Key? key}) : super(key: key);
  final VerifyController _vctrl = Get.find();
  @override
  State<Otpfield> createState() => _OtpfieldState();
}

class _OtpfieldState extends State<Otpfield> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDismissKeyboard: true,
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.dark,
      appContext: context,
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,

      pinTheme: PinTheme(
          selectedColor: ThemeColors.lightGreen,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: ThemeColors.lightGreen,
          inactiveColor: ThemeColors.darkGreen),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: ThemeColors.white,
      enableActiveFill: false,

      //errorAnimationController: errorController,
      controller: textEditingController,
      onCompleted: (v) {
        widget._vctrl.otpCode(v);
      },
      onChanged: (value) {
        print(value);
        // setState(() {

        // });
      },
    );
  }
}
