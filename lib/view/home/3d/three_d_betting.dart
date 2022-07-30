// ignore_for_file: invalid_use_of_protected_member
import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/home/3d/fast_dialog.dart';
import 'package:abc_maung/view/widgets/3D%20Betting/dream_grid_view.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:abc_maung/view/widgets/info_dialog.dart';
import 'package:abc_maung/view/widgets/load.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:abc_maung/model/2d3d_model/bet_confirm_dual.dart';

class ThreeDBetting extends StatelessWidget {
  ThreeDBetting({ Key? key }) : super(key: key);
  final ThreeDBetController _tctrl = Get.put(ThreeDBetController());
  final Controller _ctrl = Get.find();
  final _totalAmount = TextEditingController();
  final Logger log = Logger();
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

  void fast(){
    Get.dialog(
      const Padding(
        padding: EdgeInsets.all(30.0),
        child: FastDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void info(){
    Get.dialog(
      // ignore: prefer_const_constructors
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 150.0),
        child: const InfoDialog(),
      )
    );
  }
  void cancel(){
    List tmp=[];
    tmp.addAll(_tctrl.data.value);
    for(int i=0;i<1000;i++){
      tmp[i]['isSelect']=false;
    }
    _tctrl.data(tmp);
    _tctrl.reRender(_tctrl.ctrl['current'],_tctrl.ctrl['active']);
    _tctrl.isOnFast(false);
  }

  void select(int index,double percent, bool isSelect) {
    if(percent<100){      
      List tmp = [];
      tmp.addAll(_tctrl.data.value);
      tmp[index]['isSelect']=!isSelect;
      _tctrl.data(tmp);
      // for reactive
      _tctrl.reRender(_tctrl.ctrl['current'],_tctrl.ctrl['active']);
    }else{
      log.e('This Number Not Avaliable');
    }
  }

  int getIndex(String num){
    List tmp=[];
    tmp.addAll(_tctrl.data.value);
    return tmp.indexWhere((e)=>e['number']==num);
  }

  double getPercent(int index)=>_tctrl.data.value[index]['percent'];
  bool isSelected(int index)=>_tctrl.data.value[index]['isSelect'];

  void btnContinue() async {
    Load(); // TODO: test
    if (_tctrl.data.isNotEmpty) {
      if(_totalAmount.text.isNotEmpty){
        List onlySelected = _tctrl.data.value.where((e) => e['isSelect'] == true).toList();
        if (onlySelected.isNotEmpty) {
          List<String> forCheck=[];
          // when Return is true
          // ignore: dead_code
          if(_tctrl.isReturn.isTrue){
            onlySelected.forEach((element) {
              String m=element['number'];
              List<String> r=[m[0]+m[1]+m[2],m[0]+m[2]+m[1],m[1]+m[0]+m[2],m[1]+m[2]+m[0],m[2]+m[0]+m[1],m[2]+m[1]+m[0]];
              r.forEach((value) {
                if(!forCheck.contains(value)){
                  forCheck.add(value);
                }
              });
            });
          // ignore: dead_code
          }else{
            forCheck = List.generate(onlySelected.length, (i) => onlySelected[i]['number']);
          }
          
          // testing only
          // Get.toNamed('/threedcomfirm', arguments: {
          //   'data': _tctrl.data.value.where((e) => forCheck.contains(e['number']) ).toList()
          // });
          // testing only

          // TODO: remove after test
          ToConfirm toConfirm = ToConfirm(
            amount: int.parse(_totalAmount.text).abs(),
            userId: _ctrl.userId,
            number: forCheck
          );
          ApiService(Dio())
          .betConfirm(toConfirm)
          .then((value){
            List<NumberDetail> numDetail = value.numberList;
            List afterConfirm = numDetail.map((e)=>{
              'number': e.number,
              'bet_amt': value.amount,
              'get_amt': value.amount*500,
              'percent': e.percent,
              'isSelect': true,
              'valid_amount': e.validAmount
            }).toList();
            Get.back();
            Get.toNamed('/threedcomfirm', arguments: {'data': afterConfirm});
          })
          .catchError((Object obj) {
            switch (obj.runtimeType) {
              case DioError:
                ErrorResponse errorResponse = ErrorResponse(obj: obj);
                log.e(errorResponse.codeMsg);
                log.d(errorResponse.html);
                Get.back();
                Get.snackbar('ERROR ${errorResponse.code}', errorResponse.codeMsg,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 5));
                break;
              default:
            }
          });
          
          // TODO: remove after test
        } else {
          log.e('data is empty inner');
          Get.back();
          error('Error','Please Select Number');
        }
      }else{
        Get.back();
        error('Error','Please Enter Amount');
      }  
    } else {
      Get.back();
      log.e('data is empty outer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
     appBar: abcAppBar(title: 'Back',actions: action()),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            ListView(
              controller: _tctrl._scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(55.0, 20.0, 55.0, 0.0),
                  child: Column(children: [
                    Text('Total Amount'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.darkGreen),
                    ),
                    const SizedBox(height: 15.0,),
                    Row(children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 40,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              width: 3.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              controller: _totalAmount,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                hintText: '0',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ),
                      const SizedBox(width: 18.0,),
                      Obx(()=>Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () => _tctrl.isOnFast.isTrue?cancel():fast(),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _tctrl.isOnFast.isTrue?
                                ThemeColors.gold
                                :ThemeColors.lightGreen,
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Text(
                              _tctrl.isOnFast.isTrue?'cancel'.tr:'Fast'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _tctrl.isOnFast.isTrue?Colors.black:Colors.white,
                              )
                            )
                          ),
                        )
                      ))
                    ],),
                    const SizedBox(height: 15.0,),
                    Row(children: [
                      Obx( ()=>
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: (){
                            _tctrl.isDream(!_tctrl.isDream.isTrue);
                          },
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: _tctrl.isDream.isTrue?
                              const Color.fromRGBO(232, 183, 48,1)
                              :ThemeColors.lightGreen,
                            ),
                            child: Row(children: [
                              Text(
                                'Dream'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: _tctrl.isDream.isTrue?Colors.black:Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10.0,),
                              Icon(Icons.bedtime,color: _tctrl.isDream.isTrue?Colors.black:Colors.white, ),
                            ],mainAxisAlignment: MainAxisAlignment.center,),
                          ),
                        ),
                      ),),
                      const SizedBox(width: 18.0,),
                      Obx( ()=>
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: ()=>_tctrl.isReturn(!_tctrl.isReturn.isTrue),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: _tctrl.isReturn.isTrue?
                              const Color.fromRGBO(232, 183, 48,1)
                              :ThemeColors.lightGreen,
                            ),
                            child: Text(
                              'R',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _tctrl.isReturn.isTrue?Colors.black:Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )

                      )
                    ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                    const SizedBox(height: 15.0,),
                    Obx( ()=>
                    Row(children: [
                      Text(
                        _tctrl.isDream.isTrue?
                        'Choose Dream Number'.tr:
                        'Choose Betting Number'.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.darkGreen),
                      ),
                    ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                    ),
                    // hide on Dream
                    // Obx( ()=>
                    Visibility(
                      // visible: _tctrl.isDream.isFalse,
                      visible: true,
                      child: Row(children: [
                        TextButton.icon(
                          onPressed: ()=>info(),
                          icon: const Icon(Icons.info,color: Color.fromRGBO(254, 155, 75, 1),),
                          label: Text('For More Information.'.tr,style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(136, 135, 156, 1)
                          ),),),
                      ],),
                    ),
                    // ),
                    const SizedBox(height: 20.0,),
                  ],crossAxisAlignment: CrossAxisAlignment.start,),             

                ),
                
                Obx( () => 

                Visibility(
                  visible: _tctrl.isDream.isFalse,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _tctrl.ctrl.value['len'],
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        String num = _tctrl.data.value[_tctrl.ctrl.value['current']+index]['number'];
                        double percent = _tctrl.data.value[_tctrl.ctrl.value['current']+index]['percent'];
                        bool isSelect = _tctrl.data.value[_tctrl.ctrl.value['current']+index]['isSelect'];
                        var primary = boxColor['primary'];
                        var secoundry = boxColor['secoundry'];
                        var border = boxColor['border'];
                        return GestureDetector(
                          onTap: () => select(_tctrl.ctrl.value['current']+index, percent, isSelect),
                          child: Container(
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
                          ),
                        );
                      }),
                    ),
                ),
                ),
                
                Obx( () => 
                Visibility(
                  visible: _tctrl.isDream.isTrue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: 
                    DreamGridView(
                      select: select,
                      getIndex: getIndex,
                      isSelected: isSelected,
                      getPercent: getPercent,
                      boxColor: boxColor,
                    )
                  )
                ),
                ),
                const SizedBox(
                  height: 20.0,
                ),    

                Obx( ()=>
                Visibility(
                  visible: _tctrl.isDream.isFalse,
                  child: paginate(
                    one: _tctrl.page.value[_tctrl.pageIndex.value]['one'],
                    two: _tctrl.page.value[_tctrl.pageIndex.value]['two'],
                    three: _tctrl.page.value[_tctrl.pageIndex.value]['three']
                  ),
                )
                ),

                Obx( ()=>
                  Visibility(
                    visible: _tctrl.isDream.isTrue,
                    child: Row(children: [
                      GestureDetector(
                        onTap: (){
                          if(_tctrl.onSeeMore.isFalse){
                            log.e(_tctrl.start.value);
                            _tctrl.dreamApi(_tctrl.start.value);
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 45.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _tctrl.onSeeMore.isFalse?
                              ThemeColors.lightGreen: Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 1.5,
                                spreadRadius: 1.5,
                                offset: Offset(0,2),
                                color: Colors.grey,
                              )
                            ]
                          ),
                          child: _tctrl.onSeeMore.isFalse?
                          Text(
                            _tctrl.start.value==1000?
                            'go top'.tr:
                            'see more'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )
                          ): 
                          SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: CircularProgressIndicator(color: Colors.white,)
                          ),
                        ),
                      )
                    ],mainAxisAlignment: MainAxisAlignment.center,)
                  )
                ),

                const SizedBox(
                  height: 30.0,
                ),
                
              ],
            ),

            Obx(()=>Visibility(
              visible: _tctrl.flex.isTrue,
              child: Container(
              // height: 0.0,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 55.0,right: 55.0,bottom: 20.0),
                child: Row(children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 40,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                width: 3.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: TextFormField(
                                controller: _totalAmount,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
                        ),
                        const SizedBox(width: 18.0,),
                        Obx(()=>Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () => _tctrl.isOnFast.isTrue?cancel():fast(),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _tctrl.isOnFast.isTrue?
                                ThemeColors.gold
                                :ThemeColors.lightGreen,
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Text(
                              _tctrl.isOnFast.isTrue?'cancel'.tr:'Fast'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _tctrl.isOnFast.isTrue?Colors.black:Colors.white,
                              )
                            )
                          ),
                        )
                      ))
                      ],),
              ),
            ),
            )
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
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
            onPressed: () => btnContinue(),
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: Text(
              'Continue'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  // Widget paginate(
  //   {required Map one,required Map two,required Map three}
  // )=> Row(children: [
  //   GestureDetector(
  //     onTap: (){
  //       if(_tctrl.pageIndex.value!=0){
  //         _tctrl.pageIndex(_tctrl.pageIndex.value-1);
  //         int active = _tctrl.ctrl.value['active']+1;
  //         _tctrl.ctrl.value = {
  //           'len':100,
  //           'current':_tctrl.pageIndex.value*100,
  //           'active':active,
  //         }.obs;
  //       }else{
  //         log.i('min');
  //       }
  //     },
  //     child: Opacity(
  //       opacity: _tctrl.pageIndex.value!=0?1.0:0.4,
  //       child: Container(
  //         width: 30.0,
  //         height: 30.0,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 1.0,
  //             color: const Color.fromRGBO(196,201,205,1)
  //           ),
  //           borderRadius: BorderRadius.circular(5.0)
  //         ),
  //         child: const Icon(Icons.keyboard_arrow_left_sharp),
  //       ),
  //     ),
  //   ),
  //   const SizedBox(width: 5.0,),
  //   Container(
  //     width: 186,
  //     height: 30,
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         width: 1.0,
  //         color: const Color.fromRGBO(196,201,205,1)
  //       ),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: Row(children: [
  //       GestureDetector(
  //         onTap: (){
  //           if(one['active']!=true){
  //             _tctrl.pageIndex(one['index']);
  //             int active = _tctrl.ctrl.value['active']+1;
  //             _tctrl.ctrl.value = {
  //               'len':100,
  //               'current':_tctrl.pageIndex.value*100,
  //               'active':active,
  //             }.obs;
  //           }else{
  //             log.i('already select');
  //           }
  //         },
  //         child: Container(
  //           width: 60,
  //           height: 30,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: one['active']==true?ThemeColors.lightGreen:null,
  //             borderRadius: BorderRadius.circular(10.0)
  //           ),
  //           child: Text(one['text'],style: TextStyle(color: one['active']==true?Colors.white:Colors.grey),),
  //         ),
  //       ),
  //       const SizedBox(width: 2.0,),
  //       GestureDetector(
  //         onTap: (){
  //           if(two['active']!=true){
  //             _tctrl.pageIndex(two['index']);
  //             int active = _tctrl.ctrl.value['active']+1;
  //             _tctrl.ctrl.value = {
  //               'len':100,
  //               'current':_tctrl.pageIndex.value*100,
  //               'active':active,
  //             }.obs;
  //           }else{
  //             log.i('already select');
  //           }
  //         },
  //         child: Container(
  //           width: 60,
  //           height: 30,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: two['active']==true?ThemeColors.lightGreen:null,
  //             borderRadius: BorderRadius.circular(10.0)
  //           ),
  //           child: Text(two['text'],style: TextStyle(color: two['active']==true?Colors.white:Colors.grey),),
  //         ),
  //       ),
  //       const SizedBox(width: 2.0,),
  //       GestureDetector(
  //         onTap: (){
  //           if(three['active']!=true){
  //             _tctrl.pageIndex(three['index']);
  //             int active = _tctrl.ctrl.value['active']+1;
  //             _tctrl.ctrl.value = {
  //               'len':100,
  //               'current':_tctrl.pageIndex.value*100,
  //               'active':active,
  //             }.obs;
  //           }else{
  //             log.i('already select');
  //           }
  //         },
  //         child: Container(
  //           width: 60,
  //           height: 30,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: three['active']==true?ThemeColors.lightGreen:null,
  //             borderRadius: BorderRadius.circular(10.0)
  //           ),
  //           child: Text(three['text'],style: TextStyle(color: three['active']==true?Colors.white:Colors.grey),),
  //         ),
  //       ),
  //     ],),
  //   ),
  //   const SizedBox(width: 5.0,),
  //   GestureDetector(
  //     onTap: (){
  //       if(_tctrl.pageIndex.value!=9){
  //         _tctrl.pageIndex(_tctrl.pageIndex.value+1);
  //         int active = _tctrl.ctrl.value['active']+1;
  //         _tctrl.ctrl.value = {
  //           'len':100,
  //           'current':_tctrl.pageIndex.value*100,
  //           'active':active,
  //         }.obs;
  //       }else{
  //         log.i('max');
  //       }
  //     },
  //     child: Opacity(
  //       opacity: _tctrl.pageIndex.value!=9?1.0:0.4,
  //       child: Container(
  //         width: 30.0,
  //         height: 30.0,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 1.0,
  //             color: const Color.fromRGBO(196,201,205,1)
  //           ),
  //           borderRadius: BorderRadius.circular(5.0)
  //         ),
  //         child: const Icon(
  //           Icons.keyboard_arrow_right_sharp,
  //         ),
  //       ),
  //     ),
  //   ),
  // ],mainAxisAlignment: MainAxisAlignment.center,);

  Widget paginate(
    {required Map one,required Map two,required Map three}
  )=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55.0),
    child: Row(children: [
      GestureDetector(
        onTap: (){
          if(_tctrl.pageIndex.value!=0){
            _tctrl.pageIndex(_tctrl.pageIndex.value-1);
            int active = _tctrl.ctrl.value['active']+1;
            _tctrl.ctrl.value = {
              'len':100,
              'current':_tctrl.pageIndex.value*100,
              'active':active,
            }.obs;
          }else{
            log.i('min');
          }
        },
        child: Opacity(
          opacity: _tctrl.pageIndex.value!=0?1.0:0.4,
          child: Container(
            width: 100.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ThemeColors.lightGreen,
              border: Border.all(
                width: 1.0,
                color: ThemeColors.lightGreen
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Row(children: [
              const Icon(Icons.keyboard_arrow_left_sharp,color: Colors.white),
              Text(
                'Back',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
            ],mainAxisAlignment: MainAxisAlignment.center,)
          ),
        ),
      ),
      
      GestureDetector(
        onTap: (){
          if(_tctrl.pageIndex.value!=9){
            _tctrl.pageIndex(_tctrl.pageIndex.value+1);
            int active = _tctrl.ctrl.value['active']+1;
            _tctrl.ctrl.value = {
              'len':100,
              'current':_tctrl.pageIndex.value*100,
              'active':active,
            }.obs;
          }else{
            log.i('max');
          }
        },
        child: Opacity(
          opacity: _tctrl.pageIndex.value!=9?1.0:0.4,
          child: Container(
            width: 100.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ThemeColors.lightGreen,
              border: Border.all(
                width: 1.0,
                color: ThemeColors.lightGreen
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Row(children: [
              Text(
                'Next',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
              const Icon(Icons.keyboard_arrow_right_sharp,color: Colors.white),
            ],mainAxisAlignment: MainAxisAlignment.center,)
          ),
        ),
      ),
    ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
  );
}

class ThreeDBetController extends GetxController {
  Logger logger = Logger();
  RxList data = [].obs;
  RxBool isOnFast = false.obs;
  RxBool isReturn = false.obs;
  RxBool isDream = false.obs;
  RxBool flex = false.obs;
  RxMap ctrl = {
    'len':100,
    'current':0,
    'active':0,
  }.obs;
  // dream
  RxList dreamData = [].obs;
  RxInt start = 0.obs;
  RxBool onSeeMore = false.obs;
  // paginate
  RxInt pageIndex = 0.obs;
  RxList page = [
    {
      'one':{'text':'000-099','index':0,'active':true},
      'two':{'text':'100-199','index':1,'active':false},
      'three':{'text':'200-299','index':2,'active':false}
    },
    {
      'one':{'text':'000-099','index':0,'active':false},
      'two':{'text':'100-199','index':1,'active':true},
      'three':{'text':'200-299','index':2,'active':false}
    },
    {
      'one':{'text':'100-199','index':1,'active':false},
      'two':{'text':'200-299','index':2,'active':true},
      'three':{'text':'300-399','index':3,'active':false}
    },
    {
      'one':{'text':'200-299','index':2,'active':false},
      'two':{'text':'300-399','index':3,'active':true},
      'three':{'text':'400-499','index':4,'active':false}
    },
    {
      'one':{'text':'300-399','index':3,'active':false},
      'two':{'text':'400-499','index':4,'active':true},
      'three':{'text':'500-599','index':5,'active':false}
    },
    {
      'one':{'text':'400-499','index':4,'active':false},
      'two':{'text':'500-599','index':5,'active':true},
      'three':{'text':'600-699','index':6,'active':false}
    },
    {
      'one':{'text':'500-599','index':5,'active':false},
      'two':{'text':'600-699','index':6,'active':true},
      'three':{'text':'700-799','index':7,'active':false}
    },
    {
      'one':{'text':'600-699','index':6,'active':false},
      'two':{'text':'700-799','index':7,'active':true},
      'three':{'text':'800-899','index':8,'active':false}
    },
    {
      'one':{'text':'700-799','index':7,'active':false},
      'two':{'text':'800-899','index':8,'active':true},
      'three':{'text':'900-999','index':9,'active':false}
    },
    {
      'one':{'text':'700-799','index':7,'active':false},
      'two':{'text':'800-899','index':8,'active':false},
      'three':{'text':'900-999','index':9,'active':true}
    },
  ].obs;
  // paginate
  final ScrollController _scrollController=ScrollController();
  final Logger log = Logger();
  // Real Time get data
  bool isClose = false;
  int isFirstTime = 1;
  String lastReadTime = '';
  List check=[
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '000',
      'end': '099'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '100',
      'end': '199'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '200',
      'end': '299'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '300',
      'end': '399'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '400',
      'end': '499'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '500',
      'end': '599'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '600',
      'end': '699'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '700',
      'end': '799'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '800',
      'end': '899'
    },
    {
      'isFirstTime': true,
      'lastReadTime': '',
      'start': '900',
      'end': '999'
    },
  ];
  // Real Time get data
  @override
  void onClose() {
    isClose=true;
    log.i('RealTime GET 3D ShutDown');
    super.onClose();
  }
  @override
  void onInit() {
    initialData();
    _scrollController.addListener(_scrollListener);
    super.onInit();
  }
  void initialData(){
    List<String> betNum = [];
    for(int i=0;i<1000;i++){
      betNum.add(
        i<10? '00' + i.toString()
        :i<100? '0' + i.toString()
        :i.toString()
      );
    }

    List generateNumber = betNum
    .map((e) => {
          'number': e,
          'bet_amt': 0,
          'get_amt': 0,
          'percent': 10.0,
          'isSelect': false,
          'valid_amount':0,
        })
    .toList();
    // temporary set
    // generateNumber[0]['percent']=59.9;
    // generateNumber[1]['percent']=89.9;
    // generateNumber[2]['percent']=95.0;
    // generateNumber[3]['percent']=100.5;
    // generateNumber[18]['isSelect']=true;
    // temporary set
    data(generateNumber);
    apiWatch();
    dreamApi(start.value);
  }
  void dreamApi(int from){
    if(from==1000){
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut
      );
    }else{   
      onSeeMore(true);
      List tmp = [];
      tmp.addAll(dreamData.value);
      ApiService(Dio())
      .getDream(from)
      .then((ans){
        start(start.value+100);
        List dream = List.generate(
          ans.data.length,
          (i) => {
            'url': ans.data[i].url,
            'title': ans.data[i].title,
            'numL': ans.data[i].numL,
            'numR': ans.data[i].numR,
          }
        );
        tmp.addAll(dream);
        dreamData(tmp);
        onSeeMore(false);
      })
      .onError((error, stackTrace){
        onSeeMore(false);
        logger.e('error');
      });
    }
  }
  void apiGet(ReqBody reqBody) {
    ApiService(Dio())
    .getData3D(reqBody.lastReadTime,reqBody.start,reqBody.end)
    .then((value){
      // ignore: prefer_is_empty
      if(value.data.length>0){
        check[reqBody.index]['isFirstTime']=false;
        check[reqBody.index]['lastReadTime']=value.lastReadTime;
        List tmp=[];
        tmp.addAll(data.value);
        for(int i=0;i<value.data.length;i++){
          // int index = tmp.indexWhere((e)=>e['number']==value.data[i].number);
          int index = int.parse(value.data[i].number);
          tmp[index]['percent']=value.data[i].percent;
          tmp[index]['valid_amount']=value.data[i].validAmount;
          if(value.data[i].percent>=100){
            tmp[index]['isSelect']=false;
          }
        }
        data(tmp);
        reRender(ctrl['current'],ctrl['active']);
        log.i('set data length is ${value.data.length} index of :${reqBody.index.toString()}');
      }
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final err = (obj as DioError).response;
          if (err != null) {
            if (err.data != null) {
              if(err.statusCode==304){
                log.d('data has no changes since ${check[reqBody.index]['lastReadTime']}');
              }
            } else {
              log.e('SEVER RESPONSE DATA IS NULL');
            }
          } else {
            log.e('SEVER RESPONSE NULL');
          }
          break;
        default:
      }
    });
  }
  void apiWatch() async{
    while (!isClose) {
      if(Get.currentRoute=='/threedbetting'){
      int i = pageIndex.value;
      ReqBody reqBody = ReqBody(
        isFirstTime: check[i]['isFirstTime'],
        lastReadTime: check[i]['lastReadTime'],
        start: check[i]['start'],
        end: check[i]['end'],
        index: i,
      );
      apiGet(reqBody);
      await Future.delayed(const Duration(seconds: 7,),(){log.d(DateTime.now().toString()+ ' delay 5s inner index: $i');});
      }else{
        log.d('watcher is sleeping!');
        await Future.delayed(
        const Duration(
          seconds: 7,
        ), () {});
      }
    }
  }
  void _scrollListener()=> flex(_scrollController.position.pixels>59?true:false);
  void reRender(int current,int active)=>ctrl({'len':100,'current':current,'active':active+1}.obs);
}

class ReqBody {
  bool isFirstTime;
  String lastReadTime;
  String start;
  String end;
  int index;
  ReqBody(
    {required this.isFirstTime,
    required this.lastReadTime,
    required this.start,
    required this.end,
    required this.index
    }
  );
}