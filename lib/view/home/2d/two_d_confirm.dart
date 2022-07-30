// ignore_for_file: invalid_use_of_protected_member
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/model/2d3d_model/bet_dual.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/home/2d/two_d_dashboard.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TowDConfirm extends StatelessWidget {
  TowDConfirm({Key? key}) : super(key: key);
  final argu = Get.arguments;
  final Logger log = Logger();
  final Controller _ctrl = Get.find();
  final LocalController _lctrl = LocalController();
  final TwoDDashboardController _tctrl = Get.find();
  final String date = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
  // ignore: prefer_function_declarations_over_variables
  Function dropDownEdit = (){};
  // ignore: prefer_function_declarations_over_variables
  Function dropDownDelete = (){};

  void btnContinue() async{
    _lctrl.isConfirmLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    if (_lctrl.data.isNotEmpty) {
      List list = _lctrl.data.value.map((e)=>{
        'number':e['number'],
        'amount':e['bet_amt'],
      }).toList();
      // testuser#0000
      ToBet toBet = ToBet(userId: _ctrl.userId,data: list);
      log.d(toBet.data);
      ApiService(Dio())
      .betTowD(toBet)
      .then((value){
        log.i(value.betList);
        _lctrl.isConfirmLoading(false);
        success();
        _ctrl.setMainBalance(value.balance);
      })
      .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            ErrorResponse errorResponse = ErrorResponse(obj: obj);
            if(errorResponse.data.isNotEmpty){
              if(errorResponse.statusCode==1){
                String message = 'user not found';
                log.e(message);
                error('Error',message);
                // Get.snackbar('Error', message,duration: const Duration(seconds: 5));
              }else if(errorResponse.statusCode==2){
                String message = 'balance insufficient';
                error('Error',message);
                log.e(message);
                // Get.snackbar('Error', message,duration: const Duration(seconds: 5));
              }else if(errorResponse.statusCode==3){
                List betList = errorResponse.data['bet_list'];
                String message = 'cannot bet all numbers';
                List tmp = [];
                tmp.addAll(_lctrl.data.value);
                for(int i=0;i<betList.length;i++){
                  if(betList[i]['betted']==false){
                    String num = betList[i]['number'];
                    int validAmount = betList[i]['valid_amount'];
                    String error = 'Maximum amount of number $num is $validAmount';
                    int index = _lctrl.data.indexWhere((e) => e['number']==num);
                    tmp[index]['error']=error;
                    tmp[index]['valid_amount']=validAmount;
                  }else{
                    String num = betList[i]['number'];
                    int index = _lctrl.data.indexWhere((e) => e['number']==num);
                    tmp[index]['error']='';
                  }
                }
                _lctrl.data(tmp);
                _lctrl.isConfirmLoading(false);
                log.e(betList);
                log.e(message);
                error('Error',message);
                // Get.snackbar('Error', message,duration: const Duration(seconds: 5));
              }
              _lctrl.isConfirmLoading(false);
            }else{
              log.e(errorResponse.codeMsg);
              error('Error',errorResponse.codeMsg);
              // Get.snackbar('Error', errorResponse.codeMsg,duration: const Duration(seconds: 5));
              _lctrl.isConfirmLoading(false);
            }
            break;
          default:
        }
      });
    }else{
      _lctrl.isConfirmLoading(false);
      log.e('data is empty');
    }  
  }

  void success(){
    Get.defaultDialog(
      title: 'Good Luck 🎉🎉🎉',
      titlePadding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            hololo(
              content:
                  'On ^$date ${_tctrl.target.value=="12:01 PM"?"morning":"evening"} ${_tctrl.target.value} the Lucky Number will announce and we wish you a great good luck.',
            ),
            const SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: SizedBox(
            height: 50.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                Get.offAllNamed('/home');
                Get.toNamed('/twodbetting');
              }
              ,
              style: ElevatedButton.styleFrom(
                  primary: ThemeColors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ]);
  }

  void edit(int index,String number){
    TextEditingController _edit = TextEditingController();
    _lctrl.error('');
    _lctrl.isEditLoading(false);
    Get.defaultDialog(
      contentPadding: const EdgeInsets.only(bottom: 30.0),
      title: '',
      content: Obx( ()=>Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: TextFormField(
            controller: _edit,
            style: TextStyle(color: _lctrl.isEditLoading.isTrue? Colors.grey: Colors.green),
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              errorText: _lctrl.error.value==''?null:_lctrl.error.value,
              labelText: 'Betting to $number',
              labelStyle: TextStyle(color: _lctrl.isEditLoading.isTrue? Colors.grey: const Color.fromRGBO(46, 204, 113, 1)),
              hintText: 'Amount',
              hintStyle: TextStyle(color: _lctrl.isEditLoading.isTrue? Colors.grey: const Color.fromRGBO(46, 204, 113, 0.5)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: _lctrl.isEditLoading.isTrue? Colors.grey: const Color.fromRGBO(46, 204, 113, 1)
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: _lctrl.isEditLoading.isTrue? Colors.grey: Colors.green
                )
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.red
                )
              ),
            )
          ),
        ),
        const SizedBox(height: 10.0,)
      ],),
      ),
      actions: [  
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.grey,         
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                  shadowColor: ThemeColors.lightGreen,
                ),
            child: Text(
              'cancel',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            onPressed: ()async{
              if(_lctrl.isEditLoading.isFalse){
                _lctrl.isEditLoading(true);
                _lctrl.error('');
                String amount = _edit.text;
                if(amount!=''){
                  ApiService(Dio())
                  .checkEdit(number, amount)
                  .then((value){
                    List tmp = [];
                    tmp.addAll(_lctrl.data);
                    tmp[index]['bet_amt']=int.parse(amount);
                    tmp[index]['error']='';
                    _lctrl.data(tmp);
                    Get.back();
                    _lctrl.isEditLoading(false);
                    log.i(value.message);
                  })
                  .catchError((Object obj) {
                    switch (obj.runtimeType) {
                      case DioError:
                        ErrorResponse errorResponse = ErrorResponse(obj: obj);
                        if(errorResponse.data.isNotEmpty){
                          int validAmount = errorResponse.data['valid_amount'];
                          String error = 'Maximum amount for $number is $validAmount';
                          _lctrl.error(error);
                          log.e(errorResponse.codeMsg);
                          _lctrl.isEditLoading(false);
                        }else{
                          _lctrl.error(errorResponse.codeMsg);
                          log.e(errorResponse.codeMsg);
                          _lctrl.isEditLoading(false);
                        }
                        break;
                      default:
                    }
                  });
                }else{
                  _lctrl.isEditLoading(false);
                  _lctrl.error('please enter amount');
                }
              }else{
                log.e('is Loading . . .');
              }
            },
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ]
    );
  }
  
  void delete(int index){
    List ass = [];
    ass.addAll(_lctrl.data.value);
    ass.removeAt(index);
    _lctrl.data(ass);
  }
  
  String total(List data){
    int total = 0;
    // print(data[0]["bet_amt"].runtimeType);
    data.forEach((e){
      int current =e['bet_amt'];
      total+=current;
    });
    return total.toString();
  }
  @override
  Widget build(BuildContext context) {
    if(_lctrl.data.isEmpty){
      List add = argu['data'];
      List tmp = add.map((e) => {
        "number": e["number"],
        "bet_amt": e["bet_amt"],
        "gKey": GlobalKey(),
        "percent": e["percent"],
        "isSelect": e["isSelect"],
        "valid_amount": e["valid_amount"],
        "error": ''
      }).toList();
      log.i(tmp);
      _lctrl.data(tmp);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: abcAppBar(title: 'Back',actions: action()),
      body: Stack(
        children: [
          GestureDetector(
            onTap: ()=> _lctrl.onDrop.isTrue? _lctrl.onDrop(false):{},
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Text(
                        'Betting Confirmation'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors.darkGreen),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Text(
                                'Number'.tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.darkGreen),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Text(
                                'Amount'.tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.darkGreen),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text(
                                'Rate'.tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.darkGreen),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text(
                                'Action'.tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.darkGreen),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
          
                    Obx(()=>Flexible(
                      child: ListView.builder(
                          // physics: const ScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: _lctrl.data.value.length,
                          itemBuilder: (context, index) {
                            String amount = _lctrl.data.value[index]['bet_amt'].toString();
                            String number = _lctrl.data.value[index]['number'];
                            double percent = _lctrl.data.value[index]['percent'];
                            String error = _lctrl.data.value[index]['error'];
                            GlobalKey _key = _lctrl.data.value[index]['gKey'];
                            return Padding(
                              padding: const EdgeInsets.only(top: 20,),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          numBox(percent: percent, num: number),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Row(
                                        children: [
                                          Text(
                                            amount + ' MMK'.tr,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: ThemeColors.darkGreen),
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Text(
                                            'x80',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: ThemeColors.darkGreen),
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: ()=>edit(index, number),
                                            child: Icon(Icons.edit),
                                          ),
                                          InkWell(
                                            onTap: ()=>delete(index),
                                            child: Icon(Icons.delete,color: Colors.red,),
                                          ),
                                          
                                          // IconButton(
                                          //   key: _key,
                                          //   onPressed: (){
                                          //     if(Get.height-_key.globalPaintBounds!.top<260){
                                          //       _lctrl.top(_key.globalPaintBounds!.top-210.0);
                                          //     }else{
                                          //       _lctrl.top(_key.globalPaintBounds!.top-80.0);
                                          //     }
                                          //     dropDownEdit = (){Icon(Icons.delete)
                                          //       edit(index, number);
                                          //       _lctrl.onDrop(false);
                                          //     };
                                          //     dropDownDelete = () {
                                          //       delete(index);
                                          //       _lctrl.onDrop(false);
                                          //     };
                                          //     _lctrl.onDrop(true);
                                          //   },
                                          //   icon: const Icon(
                                          //     IconData(0xe800, fontFamily: 'Edit', fontPackage: null,),
                                          //     color: Color.fromRGBO(51, 62, 99, 1),
                                          //     size: 30.0,
                                          //   ),
                                          // )
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                  ],
                                ),
                                error!=''?
                                Row(children: [
                                  Text(error,style: const TextStyle(color: Colors.red),)
                                ],)
                                :Container(),
                                index==(_lctrl.data.value.length-1)?
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Total'.tr,
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.poppins(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.darkGreen
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        total(_lctrl.data.value)
                                        + ' MMK'.tr,
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.poppins(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.darkGreen
                                        ),
                                      ),
                                    ),
                                  ],),
                                )
                                :Container()
                              ],)
                            );
                        })
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
          
          Obx(()=> dropdown() ),

        ],
      ),
      bottomNavigationBar: Container(
        height: 95.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 30),
          child: Obx(()=>
            ElevatedButton(
              onPressed: () => _lctrl.isConfirmLoading.isTrue? log.e('isLoading'): btnContinue(),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(221, 245, 225, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: Text(
                'Continue'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _lctrl.isConfirmLoading.isTrue? Colors.grey: ThemeColors.lightGreen),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdown()=> Visibility(
    visible: _lctrl.onDrop.isTrue,
    child: Padding(
      padding: EdgeInsets.only(top: _lctrl.top.value,right: 40.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
        Container(
        height: 111.0,
        width: 150.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [//BoxShadow
            BoxShadow(
              color: Colors.grey,
              offset: Offset(-5.0, 6.0),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                dropDownEdit();
              },
              child: Container(
                height: 55,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)
                  )
                ),
                child: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.darkGreen),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(height: 0.0,thickness: 1.0,color: Color.fromRGBO(178, 178, 178, 1 )),
            ),
            GestureDetector(
              onTap: (){
                dropDownDelete();
              },
              child: Container(
                height: 55,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)
                  )
                ),
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.darkGreen),
                ),
              ),
            )
          ],
        ),
      ),
      ],)
    ),
  );

  final Map<String,dynamic> boxColor = {
    'primary':{
      'high':ThemeColors.lightGreen,
      'mid':ThemeColors.gold,
      'low':const Color.fromRGBO(255, 105, 105, 1),
      'select':const Color.fromRGBO(11, 50, 28, 1),
      'close':Colors.white
    },
    'secoundry':{
      'high':Colors.white,
      'mid':Colors.white,
      'low':Colors.white,
      'select':Colors.white,
      'close':const Color.fromRGBO(129, 129, 129, 1),
    },
    'border':{
      'high':ThemeColors.lightGreen,
      'mid':ThemeColors.gold,
      'low':const Color.fromRGBO(255, 105, 105, 1),
      'select':const Color.fromRGBO(11, 50, 28, 1),
      'close': const Color.fromRGBO(207, 207, 207, 1),
    },
  };
  
  Widget numBox({bool isSelect=false,required double percent,required String num}){
    var primary = boxColor['primary'];
    var secoundry = boxColor['secoundry'];
    var border = boxColor['border'];
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4.0,
          color: isSelect?
            border['select']:
            percent<50?border['high']:
            percent<=90?border['mid']:
            percent<100?border['low']:
            border['close']
        ),
        borderRadius: BorderRadius.circular(6),
        color: isSelect?
        primary['select']:
        percent<50?primary['high']:
        percent<=90?primary['mid']:
        percent<100?primary['low']:
        primary['close']
      ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            num,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelect?
                  secoundry['select']:
                  percent<50?secoundry['high']:
                  percent<=90?secoundry['mid']:
                  percent<100?secoundry['low']:
                  secoundry['close'])
          )),
    );
  }


  Widget hololo({
      required String content,
      String marked = '^',
      Color color = Colors.green,
      double fontSize = 14.0,
    }) {
      var xyz = <Widget>[];
      xyz.add(Text(
        '    ',
        style: TextStyle(fontSize: fontSize),
      ));
      List split = content.split(' ');
      for (int x = 0; x < split.length; x++) {
        if (split[x][0] == marked) {
          String tmp = split[x].substring(1);
          xyz.add(Text(
            tmp + ' ',
            style: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
          ));
        } else {
          xyz.add(Text(
            split[x] + ' ',
            style: TextStyle(fontSize: fontSize),
          ));
        }
      }
      return Wrap(
        runSpacing: 7.0,
        children: xyz,
      );
    }
  }

class LocalController extends GetxController{
  RxList data = [].obs;
  RxString error = ''.obs;
  // loading ontab()
  RxBool isEditLoading = false.obs;
  RxBool isConfirmLoading = false.obs;
  // loading state
  // Manual Dropdown
  RxDouble top=0.0.obs;
  RxBool onDrop=false.obs;
  // Manual Dropdown
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}