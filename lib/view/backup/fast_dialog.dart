import 'package:abc_maung/view/home/2d/two_d_betting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FastDialog extends StatelessWidget {
  FastDialog({ Key? key }) : super(key: key);
  final TwoDBetController _tctrl = Get.find();
  // collection of function
  void kyee(){
    List tmp = [];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=50;i<100;i++){
      if(tmp[i]['percent']<100){
        tmp[i]['isSelect']=true;
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void nge(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<50;i++){
      if(tmp[i]['percent']<100){
        tmp[i]['isSelect']=true;
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void ma(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      if(tmp[i]['percent']<100 && (i%2==1)){
        tmp[i]['isSelect']=true;
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
    void sone(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      if(tmp[i]['percent']<100 && (i%2==0)){
        tmp[i]['isSelect']=true;
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void sonesone(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(st%2==0 && nd%2==0){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void sonema(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(st%2==0 && nd%2==1){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void masone(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(st%2==1 && nd%2==0){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void mama(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){  
        if(st%2==1 && nd%2==1){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void apu(){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(st==nd){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void contain(int num){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(st==num || nd==num){
          tmp[i]['isSelect']=true;
        }  
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void start(int num){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int st = int.parse(tmp[i]['number'][0]);
      if(tmp[i]['percent']<100){
        if(st==num){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void end(int num){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      int nd = int.parse(tmp[i]['number'][1]);
      if(tmp[i]['percent']<100){
        if(nd==num){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void hyper(List<String> nums){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=0;i<100;i++){
      if(tmp[i]['percent']<100){
        if(nums.contains(tmp[i]['number'])){
          tmp[i]['isSelect']=true;
        }
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  void withBetween(int start,int end){
    List tmp=[];
    // ignore: invalid_use_of_protected_member
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<100;i++){
      tmp[i]['isSelect']=false;
    }
    for(int i=start;i<=end;i++){
      if(tmp[i]['percent']<100){
        tmp[i]['isSelect']=true;
      }
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(true);
    Get.back();
  }
  // collection of function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.black,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close,size: 30.0,color: Colors.green,)),
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
      child: ListView(children: [
        const SizedBox(height: 10.0,),
        const Text('Single and Double size',style: TextStyle(color: Colors.grey),),
        const SizedBox(height: 20.0,),
        Row(children: [
          container1(title: 'ကြီး', tab: ()=>kyee()),const SizedBox(width: 5.0,),
          container1(title: 'ငယ်', tab: ()=>nge()),const SizedBox(width: 5.0,),
          container1(title: 'မ', tab: ()=>ma()),const SizedBox(width: 5.0,),
          container1(title: 'စုံ', tab: ()=>sone())
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          container1(title: 'စုံ စုံ', tab: ()=>sonesone()),const SizedBox(width: 5.0,),
          container1(title: 'စုံ မ', tab: ()=>sonema()),const SizedBox(width: 5.0,),
          container1(title: 'မ စုံ', tab: ()=>masone()),const SizedBox(width: 5.0,),
          container1(title: 'မမ', tab: ()=>mama()),const SizedBox(width: 5.0,),
          container1(title: 'အပူ', tab: ()=>apu())
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container2(title: '0', tab: ()=>contain(0))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '1', tab: ()=>contain(1))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '2', tab: ()=>contain(2))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '3', tab: ()=>contain(3))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '4', tab: ()=>contain(4))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '5', tab: ()=>contain(5))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '6', tab: ()=>contain(6))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '7', tab: ()=>contain(7)))
        ],),
        const SizedBox(height: 10.0,),
        Row(children: [
          Expanded(child: container2(title: '8', tab: ()=>contain(8))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '9', tab: ()=>contain(9))),const SizedBox(width: 5.0,),
          Expanded(flex: 6,child: Container()),const SizedBox(width: 25.0,),
        ],),
        const SizedBox(height: 15.0,),
        const Text('ထိပ်',style: TextStyle(color: Colors.grey),),
        const SizedBox(height: 20.0,),
        Row(children: [
          Expanded(child: container2(title: '0', tab: ()=>start(0))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '1', tab: ()=>start(1))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '2', tab: ()=>start(2))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '3', tab: ()=>start(3))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '4', tab: ()=>start(4))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '5', tab: ()=>start(5))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '6', tab: ()=>start(6))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '7', tab: ()=>start(7)))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container2(title: '8', tab: ()=>start(8))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '9', tab: ()=>start(9))),const SizedBox(width: 5.0,),
          Expanded(flex: 6,child: Container()),const SizedBox(width: 25.0,),
        ],),
        const SizedBox(height: 15.0,),
        const Text('နောက်',style: TextStyle(color: Colors.grey),),
        const SizedBox(height: 20.0,),
        Row(children: [
          Expanded(child: container2(title: '0', tab: ()=>end(0))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '1', tab: ()=>end(1))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '2', tab: ()=>end(2))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '3', tab: ()=>end(3))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '4', tab: ()=>end(4))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '5', tab: ()=>end(5))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '6', tab: ()=>end(6))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '7', tab: ()=>end(7)))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container2(title: '8', tab: ()=>end(8))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '9', tab: ()=>end(9))),const SizedBox(width: 5.0,),
          Expanded(flex: 6,child: Container()),const SizedBox(width: 25.0,),
        ],),
        const SizedBox(height: 15.0,),
        const Text('Constellation Power',style: TextStyle(color: Colors.grey),),
        const SizedBox(height: 25.0,),
        Row(children: [
          Expanded(child: container3(title: 'Constellation 07,18,24,35,69', tab: ()=>hyper(['07','18','24','35','69'])))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container3(title: 'Constellation R 70,81,42,53,96', tab: ()=>hyper(['70','81','42','53','96'])))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container3(title: 'Power 05, 16, 27, 38, 49', tab: ()=>hyper(['05','16','27','38','49'])))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(child: container3(title: 'Power R 50, 61, 72, 83, 94', tab: ()=>hyper(['50','61','72','83','94'])))
        ],),
        const SizedBox(height: 15.0,),
        const Text('20 လုံးစီ',style: TextStyle(color: Colors.grey),),
        const SizedBox(height: 20.0,),
        Row(children: [
          Expanded(child: container2(title: '00-19', tab: ()=>withBetween(0,19))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '20-39', tab: ()=>withBetween(20,39))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '40-59', tab: ()=>withBetween(40,59))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '60-79', tab: ()=>withBetween(60,79))),const SizedBox(width: 5.0,),
          Expanded(child: container2(title: '80-99', tab: ()=>withBetween(80,99)))
        ],),
        const SizedBox(height: 40.0,),
      ],),
    ),
  );
  }
  Widget container1({required String title,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      width: 50.0,
      height: 50.0,
      child: Text(title,style: textStyle(),),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: boxColor(),
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
  Widget container3({required String title,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      height: 50.0,
      child: Text('   '+title,style: textStyle(),),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: boxColor(),
          borderRadius: BorderRadius.circular(5.0)
      ),
    ),
  );
  // component
  Color boxColor()=> const Color.fromRGBO(85, 85, 85, 1);
  TextStyle textStyle()=>const TextStyle(
    color: Colors.white,
    fontSize: 18.0
    // color: Color.fromRGBO(96, 98, 102, 1),
  );
}