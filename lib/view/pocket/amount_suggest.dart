import 'package:abc_maung/constants/theme_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SuggestField extends StatelessWidget {
  TextEditingController amount;
  SuggestField({ Key? key,required this.amount }) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    SuggestController _lctrl = Get.put(SuggestController(amount: amount));
    return Column(children: [
      TextFormField(
        focusNode: _lctrl._focus,
          controller: _lctrl.amount,
          keyboardType: TextInputType.number,
          cursorHeight: 22,
          decoration: InputDecoration(
              suffixText: "MMK",
              suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
              hintText: "Eg.10000",
              hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
              ),
            ),
        ),
        const SizedBox(height: 20),
          Obx( ()=>
          Visibility(
            visible: _lctrl.onfocus.isTrue,
            child: Container(
              child: Column(children: [
                Row(children: [
                  Expanded(child: suggest(amount: '5,000', onTap: (value){_lctrl.autoComplete(value);}, value: '5000')),
                  SizedBox(width: 10.0,),
                  Expanded(child: suggest(amount: '10,000', onTap: (value){_lctrl.autoComplete(value);}, value: '10000')),
                  SizedBox(width: 10.0,),
                  Expanded(child: suggest(amount: '50,000', onTap: (value){_lctrl.autoComplete(value);}, value: '50000')),
                ],),
                SizedBox(height: 20.0,),
                Row(children: [
                  Expanded(child: suggest(amount: '100,000', onTap: (value){_lctrl.autoComplete(value);}, value: '100000')),
                  SizedBox(width: 10.0,),
                  Expanded(child: suggest(amount: '200,000', onTap: (value){_lctrl.autoComplete(value);}, value: '200000')),
                  SizedBox(width: 10.0,),
                  Expanded(child: suggest(amount: '500,000', onTap: (value){_lctrl.autoComplete(value);}, value: '500000')),
                ],),
                SizedBox(height: 20.0,),
              ],),
            ),
          ),
          ),
    ],);
  }
  Widget suggest({required String amount,required Function onTap,required String value})=> InkWell(
    onTap: ()=>onTap(value),
      child: Container(
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Text(amount),
      )
  );
} 

class SuggestController extends GetxController {
  FocusNode _focus = FocusNode();
  TextEditingController amount;
  RxBool onfocus = false.obs;
  SuggestController({required this.amount});
  @override
  void onInit() {
    print('on init');
    _focus.addListener(() {
      onfocus(_focus.hasFocus);
    });
    super.onInit();
  }

  void autoComplete(String value){
    amount.text=value;
    FocusManager.instance.primaryFocus?.unfocus();
  }
}