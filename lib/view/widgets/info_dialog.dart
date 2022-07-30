import 'package:abc_maung/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.close,color: Colors.grey,))
        ],
      ),
      body: ListView(children: [
        const SizedBox(height: 5.0,),
        Row(children: [
          Text('Understanding the Colors'.tr,style: TextStyle(fontSize: 18.0,color: Color.fromRGBO(107, 107, 125, 1)),)
        ],mainAxisAlignment: MainAxisAlignment.center,),
        const SizedBox(height: 25.0,),
        display(text: 'Selected Bet'.tr, primary: const Color.fromRGBO(11, 50, 28, 1), border: const Color.fromRGBO(11, 50, 28, 1)),
        const SizedBox(height: 15.0,),
        display(text: 'Below 50%'.tr, primary: ThemeColors.lightGreen, border: ThemeColors.lightGreen),
        const SizedBox(height: 15.0,),
        display(text: 'Between 50% to 90%'.tr, primary: ThemeColors.gold, border: ThemeColors.gold),
        const SizedBox(height: 15.0,),
        display(text: 'Above 90%'.tr, primary: const Color.fromRGBO(255, 105, 105, 1), border: const Color.fromRGBO(255, 105, 105, 1)),
        const SizedBox(height: 15.0,),
        display(text: 'Can’t Bet Anymore'.tr, primary: Colors.white, border: const Color.fromRGBO(207, 207, 207, 1)),
      ],),
    );
  }
  Widget display({
    required String text,
    required Color primary,
    required Color border,
  })=>Padding(
  padding: const EdgeInsets.only(left: 50.0),
  child: Row(children: [
      Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: primary,
          border: Border.all(
            width: 4.0,
            color: border
          )
        ),
      ),
      const SizedBox(width: 15.0,),
      const Icon(Icons.info,color: Color.fromRGBO(254, 155, 75, 1),),
      const SizedBox(width: 5.0,),
      Text(text,style: const TextStyle(fontSize: 14.0,color: Color.fromRGBO(136, 135, 156, 1)),)
    ],mainAxisAlignment: MainAxisAlignment.start,)
  );
}