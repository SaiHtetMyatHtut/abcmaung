import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);
  TextEditingController humanVerify = TextEditingController();
  void onContinue(){
    if(humanVerify.text=='GOOD LUCK!'){
      Get.offNamed('/register');
    }else{
      error('Error!', 'Incorrect text');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onContinue,
          child: Text(
            'Continue',
            style: GoogleFonts.poppins(fontSize: 18.0,fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: ThemeColors.lightGreen,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          children: [
            Column(children: [
              const SizedBox(
                height: 40.0,
              ),
              Text('Welcome',
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(46, 204, 113, 1),
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold
                )
              ),
              Text('To',
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(46, 204, 113, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                )
              ),
              Text('abc Maung',
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(46, 204, 113, 1),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Enter the follow code in the text to\n complete verification.'.tr,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Image.asset('assets/icon/welcome.png'),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Human Verification',
                      style: GoogleFonts.poppins(
                        color: ThemeColors.lightGreen, fontSize: 16
                      ),
                    ),
                  ],mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: humanVerify,
                  // keyboardType: TextInputType.number,
                  cursorHeight: 22,
                  decoration: InputDecoration(
                    suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
                    hintText: "Enter The Text Above",
                    hintStyle: GoogleFonts.poppins(color: Color.fromRGBO(46, 204, 113, 0.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
                    ),
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
