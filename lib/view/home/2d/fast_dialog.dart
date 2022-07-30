import 'package:abc_maung/view/home/2d/two_d_betting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grid_view_fast/grid_view_fast.dart';


// ignore: must_be_immutable
class FastDialog extends StatelessWidget {
  FastDialog({ Key? key }) : super(key: key);
  final TwoDBetController _tctrl = Get.find();
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
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
  // fast member
  List singleDoubleSize=[];
  List htake=[];
  List nout=[];
  // fast member
  @override
  Widget build(BuildContext context) {
    singleDoubleSize = [
      {'name':'ကြီး','tab': (){kyee();}},
      {'name':'ငယ်','tab': (){nge();}},
      {'name':'မ','tab': (){ma();}},
      {'name':'စုံ','tab': (){sone();}},
      {'name':'','tab': (){}},
      {'name':'စုံစုံ','tab': (){sonesone();}},
      {'name':'စုံမ','tab': (){sonema();}},
      {'name':'မစုံ','tab': (){masone();}},
      {'name':'မမ','tab': (){mama();}},
      {'name':'အပူး','tab': (){apu();}},
      {'name':'0','tab': (){contain(0);}},
      {'name':'1','tab': (){contain(1);}},
      {'name':'2','tab': (){contain(2);}},
      {'name':'3','tab': (){contain(3);}},
      {'name':'4','tab': (){contain(4);}},
      {'name':'5','tab': (){contain(5);}},
      {'name':'6','tab': (){contain(6);}},
      {'name':'7','tab': (){contain(7);}},
      {'name':'8','tab': (){contain(8);}},
      {'name':'9','tab': (){contain(9);}},
    ];
    htake = [
      {'name':'0','tab': (){start(0);}},
      {'name':'1','tab': (){start(1);}},
      {'name':'2','tab': (){start(2);}},
      {'name':'3','tab': (){start(3);}},
      {'name':'4','tab': (){start(4);}},
      {'name':'5','tab': (){start(5);}},
      {'name':'6','tab': (){start(6);}},
      {'name':'7','tab': (){start(7);}},
      {'name':'8','tab': (){start(8);}},
      {'name':'9','tab': (){start(9);}},
    ];
    nout = [
      {'name':'0','tab': (){end(0);}},
      {'name':'1','tab': (){end(1);}},
      {'name':'2','tab': (){end(2);}},
      {'name':'3','tab': (){end(3);}},
      {'name':'4','tab': (){end(4);}},
      {'name':'5','tab': (){end(5);}},
      {'name':'6','tab': (){end(6);}},
      {'name':'7','tab': (){end(7);}},
      {'name':'8','tab': (){end(8);}},
      {'name':'9','tab': (){end(9);}},
    ];
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close,size: 30.0,color: Colors.grey,)),
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 25.0,right: 25.0),
      child: ListView(children: [
        // const SizedBox(height: 10.0,),
        Text('Single and Double size',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 10.0,),
        GridViewFast(data: singleDoubleSize),
        const SizedBox(height: 25.0,),
        
        Text('Htake',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 10.0,),
        GridViewFast(data: htake),
        const SizedBox(height: 25.0,),

        Text('Nout',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 10.0,),
        GridViewFast(data: nout),
        const SizedBox(height: 25.0,),

        Text('Constellation Power',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 10.0,),
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
        const SizedBox(height: 25.0,),

        Text('20',style: abcStyle(15, FontWeight.bold, const Color.fromRGBO(51, 62, 99, 1))),
        const SizedBox(height: 10.0,),

        Row(children: [
          Expanded(child: container2(title: '00-19', tab: ()=>withBetween(0,19))),const SizedBox(width: 20.0,),
          Expanded(child: container2(title: '20-39', tab: ()=>withBetween(20,39))),const SizedBox(width: 20.0,),
          Expanded(child: container2(title: '40-59', tab: ()=>withBetween(40,59)))
        ],),
        const SizedBox(height: 15.0,),
        Row(children: [
          Expanded(flex: 1,child: Container(),),
          Expanded(flex: 2,child: container2(title: '60-79', tab: ()=>withBetween(60,79))),const SizedBox(width: 20.0,),
          Expanded(flex: 2,child: container2(title: '80-99', tab: ()=>withBetween(80,99))),
          Expanded(flex: 1,child: Container(),),
        ],),
        const SizedBox(height: 40.0,),
      ],),
    ),
  );
  }
  // Widget gridView({required List data})=> GridView.builder(
  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 5,
  //     crossAxisSpacing: 20,
  //     mainAxisSpacing: 20,
  //   ),
  //   physics: const NeverScrollableScrollPhysics(),
  //   shrinkWrap: true,
  //   itemCount: data.length,
  //   itemBuilder: (context,index){
  //     String name = data[index]['name'];
  //     Function onTap = data[index]['tab'];
  //     if(name=='') return Container();
  //     return GestureDetector(
  //       onTap: ()=> onTap(),
  //       child: Container(
  //         decoration: const BoxDecoration(
  //           color: Color.fromRGBO(11, 50, 28, 1),
  //           borderRadius: BorderRadius.all(Radius.circular(10.0))
  //         ),
  //         child: Text(name,style: abcStyle(14, FontWeight.normal, Colors.white),),
  //         alignment: Alignment.center,
  //       ),
  //     );
  //   }
  // );
  Widget container2({required String title,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      height: 50.0,
      child: Text(title,style: abcStyle(17, FontWeight.normal, Colors.white),),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: boxColor(),
          borderRadius: BorderRadius.circular(10.0)
      ),
    ),
  );
  Widget container3({required String title,required Function tab})=>GestureDetector(
    onTap: ()=>tab(),
    child: Container(
      height: 50.0,
      child: Text('   '+title,style: abcStyle(17, FontWeight.normal, Colors.white),),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: boxColor(),
          borderRadius: BorderRadius.circular(10.0)
      ),
    ),
  );
  // component
  Color boxColor()=> const Color.fromRGBO(11, 50, 28, 1);
}