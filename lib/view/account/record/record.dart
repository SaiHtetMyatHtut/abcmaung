import 'dart:developer';

import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class Record extends StatelessWidget {
  Record({ Key? key }) : super(key: key);
  localControl _lctrl = Get.put(localControl());
  void recordDetail({
    required String id,
    required String date,
    required String amount,
    required String action,
    required List detail,
    }){
    Get.toNamed('/account/record/detail',arguments: {
      'id': id,'date': date,'amount':amount,'action':action,'detail':detail
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: abcAppBar(title: 'Record',actions: []),
      body: Obx( ()=> ListView.builder(
        shrinkWrap: true,
        itemCount: _lctrl.data.length,
        itemBuilder: (context,index){
          String id = _lctrl.data.value[index]['id'];
          String date = _lctrl.data.value[index]['date'];
          String action = _lctrl.data.value[index]['action'];
          String status = _lctrl.data.value[index]['status'];
          String amount = _lctrl.data.value[index]['amount'];
          List detail = _lctrl.data.value[index]['detail'];
          return InkWell(
            onTap: ()=>recordDetail(id: id,date: date,action: action,amount: amount,detail: detail),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, index==0? 10.0: 5.0, 25.0, index==_lctrl.data.length-1? 50.0: 5.0),
              child: Row(children: [
              Text(date,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: ThemeColors.lightGreen,
                  fontWeight: FontWeight.normal),
              ),
              Row(children: [
                Column(children: [
                  Text(action +' | '+ status ,
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
    print(_ctrl.walletId);
    ApiService(Dio())
    .accountRecord(_ctrl.walletId)
    .then((value){
      data(
        List.generate(value.data.length, (i) => {
          'id': value.data[i].id,
          'date': value.data[i].date,
          'action': value.data[i].action,
          'amount': value.data[i].amount.toString(),
          'status': value.data[i].status,
          'detail': List.generate(value.data[i].betRecords.length, (x) => {
            'sr':(x+1).toString(),
            'number':value.data[i].betRecords[x].betNumber,
            'amount': value.data[i].betRecords[x].betAmount.toString() +' MMK'.tr
          })
        })
      );
    })
    .onError((value,_)=>null);
    super.onInit();
  }
}