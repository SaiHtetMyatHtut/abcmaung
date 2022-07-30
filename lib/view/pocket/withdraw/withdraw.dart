import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/model/transaction/cashin_both.dart';
import 'package:abc_maung/model/transaction/cashout_both.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/pocket/amount_suggest.dart';
import 'package:abc_maung/view/pocket/deposit/deposit.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Withdraw extends StatelessWidget {
  Withdraw({Key? key}) : super(key: key);
  final argu = Get.arguments;
  Controller _ctrl = Get.find();
  late String url;
  late String method;
  TextEditingController _amount = TextEditingController();
  TextEditingController _transferTo = TextEditingController();
  void btnContinue() {
    int amount = _amount.text==''? 0: int.parse(_amount.text);
    String transferTo = _transferTo.text;
    if(amount>0 && transferTo.isNotEmpty){
      ToCashOut toCashOut = ToCashOut(
        userId: _ctrl.userId,
        amount: amount,
        transferTo: transferTo,
        method: method,
      );
      ApiService(Dio())
      .cashOut(toCashOut)
      .then((value){
        Get.offNamed('/withdrawdetail', arguments: {
          'deposit_amt': value.amount,
          'date': value.date,
          'name': _ctrl.fullName,
          'transaction_id': value.tranId
        });
      })
      .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            ErrorResponse errorResponse = ErrorResponse(obj: obj);
            Get.snackbar('ERROR ${errorResponse.code}', errorResponse.codeMsg,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 5));
            break;
          default:
        }
      });
    }else if(amount==0){
      error('Error','Transfered Ammount?');
    }else if(transferTo==''){
      error('Error','Transfered Phone?');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    url = argu['url'];
    method = argu['method'];
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
          title: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                clicktoback(),
                Text(
                  'Withdraw'.tr,
                  style: GoogleFonts.poppins(
                      color: ThemeColors.lightGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        body: buildlayout(url),
        bottomNavigationBar: navbar(),
      ),
    );
   
  }
  Widget buildlayout(String url) => Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
    child: ListView(
      children: [
        wavepaybox(url),
        const SizedBox(height: 50),
        Text(
          'Your Account Phone Number'.tr,
          style: GoogleFonts.poppins(
              color: ThemeColors.lightGreen, fontSize: 16),
        ),
        phnumber(_transferTo),
        const SizedBox(height: 20),
        Text(
          'Amount Your Wanna Widraw'.tr,
          style: GoogleFonts.poppins(
              color: ThemeColors.lightGreen, fontSize: 16),
        ),
        SuggestField(
            amount: _amount,
        ),
        const SizedBox(height: 20),
      ],
    ),
  );

  Widget navbar() => Container(
        height: 95.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 30),
          child: ElevatedButton(
            onPressed: () => btnContinue(),
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Text(
              'Continue'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
}

Widget wavepaybox(String url) => Container(
      width: 355,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          height: 89,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(url)),
          ),
        ),
      ),
    );

Widget withdrawamt(TextEditingController amount) => TextFormField(
  controller: amount,
    keyboardType: TextInputType.number,
    cursorHeight: 22,
    decoration: InputDecoration(
      suffixText: "MMK",
      suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
      hintText: "Eg.100,000",
      hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
      ),
    ),
  );

Widget phnumber(TextEditingController transferTo) => TextFormField(
  controller: transferTo,
    keyboardType: TextInputType.number,
    cursorHeight: 22,
    decoration: InputDecoration(
      suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
      hintText: "099720***52",
      hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
      ),
    ),
  );

Widget clicktoback() => Container(
      margin: const EdgeInsets.only(right: 15, left: 35),
      child: Icon(
        Icons.arrow_back_sharp,
        color: ThemeColors.lightGreen,
      ),
    );
