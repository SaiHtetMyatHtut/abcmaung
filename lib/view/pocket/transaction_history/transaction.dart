import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class Transaction extends StatelessWidget {
  Transaction({ Key? key }) : super(key: key);
  localControl _lctrl = Get.put(localControl());
  void detail({
    required String id,
    required String date,
    required String amount,
    required String action,
    }){
    Get.toNamed('/transactiondetail',arguments: {
      'id': id,'date': date,'amount':amount,'action':action
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: abcAppBar(title: 'Money History'.tr,actions: []),
      body: Obx( ()=> ListView.builder(
        shrinkWrap: true,
        itemCount: _lctrl.data.value.length,
        itemBuilder: (context,index){
          String id = _lctrl.data.value[index]['id'];
          String date = _lctrl.data.value[index]['date'];
          String action = _lctrl.data.value[index]['action'];
          String amount = _lctrl.data.value[index]['amount'];
          String status = _lctrl.data.value[index]['status'];
          return InkWell(
            onTap: ()=>detail(id: id,date: date,action: action,amount: amount),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, index==0? 10.0: 5.0, 25.0, index==_lctrl.data.value.length-1? 50.0: 5.0),
              child: Row(children: [
              Text(date,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: ThemeColors.lightGreen,
                  fontWeight: FontWeight.normal),
              ),
              Row(children: [
                Column(children: [
                  Text(action +' | '+ status,
                    style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    fontWeight: FontWeight.normal),
                  ),
                  Text(amount + ' MMK',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w600),
                  )
                ],crossAxisAlignment: CrossAxisAlignment.end,),
                const SizedBox(width: 20.0,),
                const Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(0, 0, 0, 0.5),)
              ],)
            ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
            ),
          );
        }

      ),)
    );
  }
}

class localControl extends GetxController{
  RxList data = [].obs;
  @override
  void onInit() {
    Controller _ctrl = Get.find();
    ApiService(Dio())
    .walletRecord(_ctrl.walletId)
    .then((value){
      data(
        List.generate(value.history.length, (i) => {
          'id': value.history[i].id,
          'date': value.history[i].date,
          'action': value.history[i].action,
          'amount': value.history[i].amount.toString(),
          'status': value.history[i].status,
        })
      );
    })
    .onError((value,_)=>null);
    super.onInit();
  }
}