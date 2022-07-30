import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:abc_maung/view/widgets/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:get/get.dart';

class RecordDetail extends StatelessWidget {
  RecordDetail({Key? key}) : super(key: key);
  final argu = Get.arguments;
  final Controller _ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    String name = _ctrl.fullName;
    String date = argu['date'];
    String id = argu['id'];
    String amount = argu['amount'];
    String action = argu['action'];
    List detail = argu['detail'];
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: abcAppBar(title: 'Record Detail'.tr,actions: []),
      body: _buildlayout(id: id,date: date,amount: amount,action: action,detail: detail, name: name),
      bottomNavigationBar: navbar(),
    );
  }

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
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Text(
              'Done'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );

}

Widget _buildlayout({required String date,required String amount,required String action,required List detail, required String name,required String id}) => Container(
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: ListView(
        children: [
          firstrow(date,name),
          const SizedBox(height: 30),
          Dash(),
          const SizedBox(height: 22),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: detail.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(children: [
                  Expanded(child: 
                    Text(
                      detail[index]['sr'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.darkGreen
                      )
                    )
                  ),
                  Expanded(child: 
                    Text(
                      detail[index]['number'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: ThemeColors.darkGreen
                      )
                    )
                  ),
                  Expanded(child: 
                    Text(
                      detail[index]['amount'],
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.darkGreen
                      )
                    )
                  ),
                ],),
              );
            }
          ),
          secondrow(amount),
          const SizedBox(height: 22),
          Dash(),
          const SizedBox(height: 50),
          Text('If Any Issue Contact Customer Support\n With Following ID'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w400
            )
          ),
          const SizedBox(height: 20),
          idBox(id),
        ],
      ),
    );

Widget firstrow(String date,String name) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 4,
            ),
            Text(name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        Container(
          // width: 65,
          // height: 50,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10),
            //image: const DecorationImage(
            //image: AssetImage('assetName'),
            //fit: BoxFit.cover,
            //),
          ),
        ),
      ],
    );

Widget secondrow(String amount) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total Payment'.tr,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
        Text(amount+' MMK'.tr,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeColors.lightGreen)),
      ],
    );

Widget idBox(String id) => Column(children: [
  Text(id,
    style: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ThemeColors.lightGreen
    )
  ),
  TextButton.icon(
    onPressed: (){
      Clipboard.setData(ClipboardData(text: id));
      // Clipboard.getData(Clipboard.kTextPlain).then((value){ 
      //     print(value!.text); //value is clipbarod data
      // });
    },
    icon: Icon(Icons.copy,color: Colors.black,),
    label: Text('copy'.tr,style: TextStyle(color: Colors.black),),
  ),
],crossAxisAlignment: CrossAxisAlignment.center,);

Widget clicktoback() => Container(
      margin: const EdgeInsets.only(right: 15, left: 35),
      child: Icon(
        Icons.arrow_back_sharp,
        color: ThemeColors.lightGreen,
      ),
    );
