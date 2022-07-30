// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';

import 'package:abc_maung/view/home/3d/three_d_betting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class FastDialog extends StatefulWidget {
  const FastDialog({ Key? key }) : super(key: key);
  @override
  State<FastDialog> createState() => _FastDialogState();
}

class _FastDialogState extends State<FastDialog> {
  final ThreeDBetController _tctrl = Get.find();
  Logger log = Logger();
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  List apuu = [
    {'number':'000','isSelect':false},
    {'number':'111','isSelect':false},
    {'number':'222','isSelect':false},
    {'number':'333','isSelect':false},
    {'number':'444','isSelect':false},
    {'number':'555','isSelect':false},
    {'number':'666','isSelect':false},
    {'number':'777','isSelect':false},
    {'number':'888','isSelect':false},
    {'number':'999','isSelect':false},
  ];
  List combo = [
    {'number':'000-099','start': 0,'end': 99,'isSelect':false},
    {'number':'100-199','start': 100,'end': 199,'isSelect':false},
    {'number':'200-299','start': 200,'end': 299,'isSelect':false},
    {'number':'300-399','start': 300,'end': 399,'isSelect':false},
    {'number':'400-499','start': 400,'end': 499,'isSelect':false},
    {'number':'500-599','start': 500,'end': 599,'isSelect':false},
    {'number':'600-699','start': 600,'end': 699,'isSelect':false},
    {'number':'700-799','start': 700,'end': 799,'isSelect':false},
    {'number':'800-899','start': 800,'end': 899,'isSelect':false},
    {'number':'900-999','start': 900,'end': 999,'isSelect':false},
  ];
  // collection of function
  void apu(int index){
    // deselect
    for(int s=0;s<combo.length;s++){
      int start = combo[s]['start'];
      int end = combo[s]['end'];
      bool isSelect = combo[s]['isSelect'];
      if(isSelect){
        List tmp=[];
        tmp.addAll(_tctrl.data.value);
        for (start;start<=end;start++){
          tmp[start]['isSelect']=false;
        }
        setState(() {
          combo[s]['isSelect']=!isSelect;
        });
        _tctrl.data(tmp);
      }
    }
    // deselect
    bool isSelect = apuu[index]['isSelect'];
    String number = apuu[index]['number'];
    List tmp=[];
    tmp.addAll(_tctrl.data.value);
    int i = tmp.indexWhere((e) => e['number']==number);
    if(tmp[i]['percent']<100){
      tmp[i]['isSelect']=!isSelect;
      _tctrl.data(tmp);
      setState(() {
        apuu[index]['isSelect']=!isSelect;
      });
      _tctrl.isOnFast(true);
      // for reactive
      int current = _tctrl.ctrl.value['current'];
      int active = _tctrl.ctrl.value['active']+1;
      _tctrl.reRender(current, active);
      // for reactive
    }
  }

  void comb(int index){
    // deselect apuu
    List tmp=[];
    List apu=[0,111,222,333,444,555,666,777,888,999];
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<apu.length;i++){
      if(!combo[i]['isSelect']) tmp[apu[i]]['isSelect']=false;
      setState(() {
        if(!combo[i]['isSelect']) apuu[i]['isSelect']=false;
      });
    }
    // print(apuu);
    _tctrl.data(tmp);
    // deselect apuu
    int start = combo[index]['start'];
    int end = combo[index]['end'];
    bool isSelect = combo[index]['isSelect'];
    tmp=[];
    tmp.addAll(_tctrl.data.value);
    for (start;start<=end;start++){
      if(tmp[start]['percent']<100){
        tmp[start]['isSelect']=!isSelect;
        if(tmp[start]['number']=='111') log.d(' There ${!isSelect}');
      }else{
        tmp[start]['isSelect']=false;
      }
    }
    _tctrl.data(tmp);
    setState(() {
      combo[index]['isSelect']=!isSelect;
    });
    _tctrl.isOnFast(true);
    // for reactive
    int current = _tctrl.ctrl.value['current'];
    int active = _tctrl.ctrl.value['active']+1;
    _tctrl.reRender(current, active);
    // for reactive
  }

  void deselect(){
    List tmp=[];
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<1000;i++){
      tmp[i]['isSelect']=false;
    }
    _tctrl.data(tmp);
  }
  // collection of function

  @override
  void initState() {
    deselect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // backgroundColor: Colors.black,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: (){
            _tctrl.isOnFast(true);
            // for reactive
            int current = _tctrl.ctrl.value['current'];
            int active = _tctrl.ctrl.value['active']+1;
            _tctrl.ctrl.value={
              'len':100,
              'current':current,
              'active':active,
            }.obs;
            // for reactive
            Get.back();
          }, icon: const Icon(Icons.close,size: 30.0,color: Colors.green,)),
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
      child: ListView(children: [
        const SizedBox(height: 10.0,),
        // const Text('(၃) လုံးပူးဂဏန်းများ',style: TextStyle(color: Colors.grey),),
        Text('(၃) လုံးပူးဂဏန်းများ',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
       const SizedBox(height: 20.0,),
       Row(children: [
         Expanded(flex: 1,child: container1(title: apuu[0]['number'],isSelect: apuu[0]['isSelect'], tab: ()=>apu(0)),),const SizedBox(width: 5.0,),
         Expanded(flex: 1,child: container1(title: apuu[1]['number'],isSelect: apuu[1]['isSelect'], tab: ()=>apu(1)),),const SizedBox(width: 5.0,),
         Expanded(flex: 1,child: container1(title: apuu[2]['number'],isSelect: apuu[2]['isSelect'], tab: ()=>apu(2)),),const SizedBox(width: 5.0,),
         Expanded(flex: 1,child: container1(title: apuu[3]['number'],isSelect: apuu[3]['isSelect'], tab: ()=>apu(3)),)
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(flex: 1,child: container1(title: apuu[4]['number'],isSelect: apuu[4]['isSelect'], tab: ()=>apu(4)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: apuu[5]['number'],isSelect: apuu[5]['isSelect'], tab: ()=>apu(5)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: apuu[6]['number'],isSelect: apuu[6]['isSelect'], tab: ()=>apu(6)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: apuu[7]['number'],isSelect: apuu[7]['isSelect'], tab: ()=>apu(7)),)
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(flex: 1,child: container1(title: apuu[8]['number'],isSelect: apuu[8]['isSelect'], tab: ()=>apu(8)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: apuu[9]['number'],isSelect: apuu[9]['isSelect'], tab: ()=>apu(9)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: Container(),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: Container(),)
        ],),
        const SizedBox(height: 20.0,),
        // const Text('100 လုံးစီ',style: TextStyle(color: Colors.grey),),
        Text('100 လုံးစီ',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 20.0,),
        Row(children: [
          Expanded(flex: 1,child: container1(title: combo[0]['number'],isSelect: combo[0]['isSelect'], tab: ()=>comb(0)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[1]['number'],isSelect: combo[1]['isSelect'], tab: ()=>comb(1)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[2]['number'],isSelect: combo[2]['isSelect'], tab: ()=>comb(2)),)
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(flex: 1,child: container1(title: combo[3]['number'],isSelect: combo[3]['isSelect'], tab: ()=>comb(3)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[4]['number'],isSelect: combo[4]['isSelect'], tab: ()=>comb(4)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[5]['number'],isSelect: combo[5]['isSelect'], tab: ()=>comb(5)),)
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(flex: 1,child: container1(title: combo[6]['number'],isSelect: combo[6]['isSelect'], tab: ()=>comb(6)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[7]['number'],isSelect: combo[7]['isSelect'], tab: ()=>comb(7)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[8]['number'],isSelect: combo[8]['isSelect'], tab: ()=>comb(8)),)
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(flex: 1,child: Container()),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: combo[9]['number'],isSelect: combo[9]['isSelect'], tab: ()=>comb(9)),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: Container())
        ],),
        const SizedBox(height: 30.0,),
        Row(children: [
          Expanded(flex: 1,child: Container()),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: container1(title: 'Back',isSelect: true, tab: (){
            // for reactive
            int current = _tctrl.ctrl.value['current'];
            int active = _tctrl.ctrl.value['active']+1;
            _tctrl.ctrl.value={
              'len':100,
              'current':current,
              'active':active,
            }.obs;
            // for reactive
            Get.back();
          }),),const SizedBox(width: 5.0,),
          Expanded(flex: 1,child: Container())
        ],),
        const SizedBox(height: 40.0,),
      ],),
    ),
  );
  }

  Widget container1({required String title,required bool isSelect,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      height: 40.0,
      child: Text(title,style: isSelect? textSelect():textStyle(),),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelect?boxSelect(): boxColor(),
          borderRadius: BorderRadius.circular(5.0)
      ),
    ),
  );

  Widget container2({required String title,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      height: 50.0,
      child: Text(title,style: textStyle(),),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: boxColor(),
          borderRadius: BorderRadius.circular(5.0)
      ),
    ),
  );

  // component
  Color boxColor()=> const Color.fromRGBO(11, 50, 28, 1);

  Color boxSelect()=> const Color.fromRGBO(232, 183, 48,1);

  TextStyle textStyle()=> abcStyle(17, FontWeight.normal, Colors.white);
  // const TextStyle(
  //   color: Colors.white,
  //   fontSize: 18.0
  //   // color: Color.fromRGBO(96, 98, 102, 1),
  // );

  TextStyle textSelect()=> abcStyle(17, FontWeight.normal, Colors.black);
  // const TextStyle(
  //   color: Colors.black,
  //   fontSize: 18.0
  //   // color: Color.fromRGBO(96, 98, 102, 1),
  // );
}

// class ButtonController extends GetxController {
//   RxList apuu = [
//     {'number':'111','isSelect':false},
//     {'number':'222','isSelect':false},
//     {'number':'333','isSelect':false},
//     {'number':'444','isSelect':false},
//     {'number':'555','isSelect':false},
//     {'number':'666','isSelect':false},
//     {'number':'777','isSelect':false},
//     {'number':'888','isSelect':false},
//     {'number':'999','isSelect':false},
//     {'number':'000','isSelect':false},
//   ].obs;
//   @override
//   void onClose() {
//     print('on close: &&');
//     super.onClose();
//   }
// }