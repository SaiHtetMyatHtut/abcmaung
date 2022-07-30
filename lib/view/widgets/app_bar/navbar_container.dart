import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/view/widgets/app_bar/navbar_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NavContainer extends StatelessWidget {
  NavContainer({ Key? key }) : super(key: key);
  Controller _ctrl = Get.find();
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.0,
      color: Color.fromRGBO(46, 204, 113, 1),
      child: Stack(children: [
        CustomPaint(
            size: Size(Get.width*0.45, 68.0,), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: NavPainter(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Container(
            width: Get.width*0.241545,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset('assets/icon/abc_logo.png',fit: BoxFit.fitWidth,),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.width*0.45,right: 30.0),
          child: Row(children: [
            Expanded(
              flex: 3,
              child: Column(children: [
                Text('Wallet',
                  style: abcStyle(
                    11.0, 
                    FontWeight.normal, 
                    Colors.white
                  ),
                ),
                Text('abc Coin',
                  style: abcStyle(
                    11.0, 
                    FontWeight.normal, 
                    Colors.white
                  ),
                ),
              ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,)
            ),
            Obx( ()=>
            Expanded(
              flex: 5,
              child: Column(children: [
                Text(_ctrl.mainBalance.value.toString() + ' MMK',
                  style: abcStyle(
                    11.0, 
                    FontWeight.normal, 
                    Colors.white
                  ),
                ),
                Text(_ctrl.gameBalance.value.toString() + ' Coin',
                  style: abcStyle(
                    11.0,
                    FontWeight.normal, 
                    Colors.white
                  ),
                ),
              ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.end,)
            ),),
            SizedBox(width: 5.0,),
            InkWell(
              onTap: (){},
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 155, 75, 1),
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Icon(Icons.swap_horiz),
              ),
            )
          ],),
        )
      ],),
    );
  }
}