import 'package:abc_maung/abc_icon/abc_icon_icons.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/view/home/2d/dashboard/bet_layout.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
// import 'package:bet_dashboard/bet_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoDClose extends StatelessWidget {
  TwoDClose({Key? key}) : super(key: key);
  final _lctrl = Get.put(TwoDCloseController());
  void betButtom()=>Get.toNamed('/twodbetting');

  @override
  Widget build(BuildContext context) {
    return BETScaffold(
      appBar: abcAppBar(title: 'Back',actions: []),
      body: Obx( ()=> BetDashboard(
        iconData: AbcIcon.close,
        title: 'Close Date'.tr,
        tableHead: ['Name'.tr,'Date'.tr,'Day Left'.tr],
        // tableBody: List<List<String>>.generate(20, (index) => ['Chirsmas','$index-12-2021','12']),
        // ignore: invalid_use_of_protected_member
        tableBody: _lctrl.data.value,
        message: _lctrl.message.value.tr,
      ),),
      bottomNaviCallBack: betButtom,
    );
  }
}

class TwoDCloseController extends GetxController{
  RxString message='Please Wait  .  .  .'.obs;
  RxList data=[].obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }
  void getData(){
    ApiService(Dio())
    .get2DHoliday()
    .then((value){
      if(value.data.isNotEmpty){
        data(
          List<List<String>>.generate(value.data.length, 
            (i) => [value.data[i].name,value.data[i].date,value.data[i].dayLeft.toString()]
          )
        );
      }else{
        message('No information yet');
      }
    });
  }
}


class BetDashboard extends StatelessWidget {
  final Color primarycolor = const Color.fromRGBO(51, 62, 99, 1);
  final Color secondarycolor = const Color.fromRGBO(88, 214, 141, 1);
  final IconData iconData;
  final String title;
  final List<String> tableHead;
  final List tableBody;
  final String message;
  const BetDashboard({
    Key? key,
    required this.iconData,
    required this.title,
    required this.tableHead,
    required this.tableBody,
    required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titlestyle = GoogleFonts.poppins(
      fontSize: 18,
      color: primarycolor,
      fontWeight: FontWeight.w500,
    );
    final headstyle = GoogleFonts.poppins(
      fontSize: 16,
      color: secondarycolor,
      fontWeight: FontWeight.normal,
    );
    final bodystyle = GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: primarycolor,
    );
    final firstPlace = GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      color: primarycolor,
    );
    final secondPlace = GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: primarycolor,
    );
    List<Widget> row = List<Widget>.generate(
        tableBody.length,
        (index) => Container(
          color: Color.fromRGBO(213, 245, 227, 
            index%2==1?0:0.5
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 12,
                      child: Row(
                        children: [
                          Container(
                            width: 130.0,
                            // height: 30.0,
                            child: Text(tableBody[index][0], style: 
                              title=='Winner'&&index==0?firstPlace:
                              title=='Winner'&&index==1?secondPlace:
                              bodystyle
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Row(
                        children: [
                          Text(tableBody[index][1], style: bodystyle),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Text(tableBody[index][2], style: bodystyle),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    )
                  ],
                ),
          ),
        ));

    return Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
        child: Column(children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 30.0,
                color: primarycolor,
              ),
              const SizedBox(width: 20.0),
              Text(title, style: titlestyle),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Row(
                  children: [
                    Text(tableHead[0], style: headstyle),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Expanded(
                flex: 11,
                child: Row(
                  children: [
                    Text(tableHead[1], style: headstyle),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Text(tableHead[2], style: headstyle),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          tableBody.isEmpty==true?
          Container(
            height: 350,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(message,style: titlestyle,),
          ):
          Flexible(
            child: ListView.builder(
                itemCount: tableBody.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: row[index]);
                }),
          )
        ]));
  }
}
