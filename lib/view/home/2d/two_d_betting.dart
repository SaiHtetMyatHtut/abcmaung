// ignore_for_file: invalid_use_of_protected_member
import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/view/home/2d/fast_dialog.dart';
import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:abc_maung/view/widgets/info_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TwoDBetting extends StatelessWidget {
  TwoDBetting({Key? key}) : super(key: key);
  final Controller _ctrl = Get.find();
  final TwoDBetController _tctrl = Get.put(TwoDBetController());
  final _totalAmount = TextEditingController();
  final Logger log = Logger();

  final Map<String, dynamic> boxColor = {
    'primary': {
      'high': ThemeColors.lightGreen,
      'mid': ThemeColors.gold,
      'low': const Color.fromRGBO(255, 105, 105, 1),
      'select': const Color.fromRGBO(11, 50, 28, 1),
      'close': Colors.white
    },
    'secoundry': {
      'high': Colors.white,
      'mid': Colors.white,
      'low': Colors.white,
      'select': Colors.white,
      'close': const Color.fromRGBO(129, 129, 129, 1),
    },
    'border': {
      'high': ThemeColors.lightGreen,
      'mid': ThemeColors.gold,
      'low': const Color.fromRGBO(255, 105, 105, 1),
      'select': const Color.fromRGBO(11, 50, 28, 1),
      'close': const Color.fromRGBO(207, 207, 207, 1),
    },
  };

  void fast() {
    Get.dialog(Padding(
      padding: const EdgeInsets.all(30.0),
      child: FastDialog()
    ));
  }

  void info() {
    Get.dialog(
        // ignore: prefer_const_constructors
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 150.0),
      // child: InfoDialog(),
      child: const InfoDialog(),
    ));
  }

  void cancel() {
    List tmp = [];
    tmp.addAll(_tctrl.data.value);
    for (int i = 0; i < 100; i++) {
      tmp[i]['isSelect'] = false;
    }
    _tctrl.data(tmp);
    _tctrl.isOnFast(false);
  }

  void select(int index, double percent, bool isSelect) {
    if (percent < 100) {
      List tmp = [];
      tmp.addAll(_tctrl.data.value);
      tmp[index]['isSelect'] = !isSelect;
      _tctrl.data(tmp);
    } else {
      log.e('This Number Not Avaliable');
    }
  }

  void btnContinue() {
    if (_tctrl.data.isNotEmpty) {
      if (_totalAmount.text.isNotEmpty) {
        List onlySelected =
            _tctrl.data.value.where((e) => e['isSelect'] == true).toList();
        for (int i = 0; i < onlySelected.length; i++) {
          onlySelected[i]['bet_amt'] = int.parse(_totalAmount.text).abs();
          // onlySelected[i]['get_amt'] =
          //     (int.parse(_totalAmount.text) * 80).toString();
        }
        if (onlySelected.isNotEmpty) {
          Get.toNamed('/towdcomfirm', arguments: {
            'data': onlySelected,
          });
          // log.i('data len : ${onlySelected}');
        } else {
          log.e('data is empty inner');
          error('Error', 'Please Select Number');
        }
      } else {
        error('Error', 'Please Enter Amount');
      }
    } else {
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
                    child: Column(
                      children: [
                        Text(
                          'Total Amount'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.darkGreen),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                  height: 40,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          242, 242, 242, 1),
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
                                )),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Obx(() => Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () => _tctrl.isOnFast.isTrue? cancel()
                                          : fast(),
                                    child: Container(
                                      height: 45.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _tctrl.isOnFast.isTrue
                                            ? ThemeColors.gold
                                            : ThemeColors.lightGreen,
                                        borderRadius: BorderRadius.circular(5.0)
                                      ),
                                      child: Text(
                                          _tctrl.isOnFast.isTrue
                                              ? 'cancel'.tr
                                              : 'Fast'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: _tctrl.isOnFast.isTrue
                                                ? Colors.black
                                                : Colors.white,
                                          )
                                      ) ,
                                    )
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Choose Betting Number'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.darkGreen),
                        ),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => info(),
                              icon: const Icon(
                                Icons.info,
                                color: Color.fromRGBO(254, 155, 75, 1),
                              ),
                              label: Text(
                                'For More Information.'.tr,
                                style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromRGBO(136, 135, 156, 1)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _tctrl.data.value.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            String num = _tctrl.data.value[index]['number'];
                            double percent =
                                _tctrl.data.value[index]['percent'];
                            bool isSelect =
                                _tctrl.data.value[index]['isSelect'];
                            var primary = boxColor['primary'];
                            var secoundry = boxColor['secoundry'];
                            var border = boxColor['border'];
                            return GestureDetector(
                              onTap: () => select(index, percent, isSelect),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4.0,
                                        color: isSelect
                                            ? border['select']
                                            : percent < 50
                                                ? border['high']
                                                : percent <= 90
                                                    ? border['mid']
                                                    : percent < 100
                                                        ? border['low']
                                                        : border['close']),
                                    borderRadius: BorderRadius.circular(6),
                                    color: isSelect
                                        ? primary['select']
                                        : percent < 50
                                            ? primary['high']
                                            : percent <= 90
                                                ? primary['mid']
                                                : percent < 100
                                                    ? primary['low']
                                                    : primary['close']),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(num,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: isSelect
                                                ? secoundry['select']
                                                : percent < 50
                                                    ? secoundry['high']
                                                    : percent <= 90
                                                        ? secoundry['mid']
                                                        : percent < 100
                                                            ? secoundry['low']
                                                            : secoundry[
                                                                'close']))),
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                ],
              ),
              Obx(() => Visibility(
                    visible: _tctrl.flex.isTrue,
                    child: Container(
                      // height: 0.0,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 55.0, right: 55.0, bottom: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                  height: 40,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          242, 242, 242, 1),
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
                                )),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Obx(() => Expanded(
                              flex: 2,
                              child: InkWell(
                                    onTap: () => _tctrl.isOnFast.isTrue? cancel()
                                          : fast(),
                                    child: Container(
                                      height: 45.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _tctrl.isOnFast.isTrue
                                            ? ThemeColors.gold
                                            : ThemeColors.lightGreen,
                                        borderRadius: BorderRadius.circular(5.0)
                                      ),
                                      child: Text(
                                          _tctrl.isOnFast.isTrue
                                              ? 'cancel'.tr
                                              : 'Fast'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: _tctrl.isOnFast.isTrue
                                                ? Colors.black
                                                : Colors.white,
                                          )
                                      ) ,
                                    )
                                  ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          )),
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
}

class TwoDBetController extends GetxController {
  RxList data = [].obs;
  RxBool isOnFast = false.obs;
  RxBool flex = false.obs;
  final ScrollController _scrollController = ScrollController();
  final Logger log = Logger();
  // Real Time get data
  bool isClose = false;
  bool isFirstTime = true;
  String lastReadTime = '';
  // Real Time get data
  @override
  void onClose() {
    isClose = true;
    log.i('RealTime GET 2D ShutDown');
    super.onClose();
  }

  @override
  void onInit() {
    initialData();
    _scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void initialData() {
    List<String> betNum = [];
    for (int i = 0; i < 100; i++) {
      betNum.add(i < 10 ? '0' + i.toString() : i.toString());
    }

    List generateNumber = betNum
        .map((e) => {
              'number': e,
              'bet_amt': 0,
              'get_amt': 0,
              'percent': 10.0,
              'isSelect': false,
              'valid_amount': 0,
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
  }

  void apiWatch() async {
    while (!isClose) {
      if(Get.currentRoute=='/twodbetting'){
        ApiService(Dio()).getData(lastReadTime).then((value) {
          // ignore: prefer_is_empty
          if (value.data.length > 0) {
            isFirstTime = false;
            lastReadTime = value.lastReadTime;
            List tmp = [];
            tmp.addAll(data.value);

            for (int i = 0; i < value.data.length; i++) {
              // int index =
              //     tmp.indexWhere((e) => e['number'] == value.data[i].number);
              int index = int.parse(value.data[i].number);
              tmp[index]['percent'] = value.data[i].percent;
              tmp[index]['valid_amount'] = value.data[i].validAmount;
              if (value.data[i].percent >= 100) {
                tmp[index]['isSelect'] = false;
              }
            }
            data(tmp);
            log.i('set data length is ${value.data.length}');
          }
          // else{
          //   log.d('data has no changes since $lastReadTime');
          //   lastReadTime=value.lastReadTime;
          // }
        }).catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
              final err = (obj as DioError).response;
              if (err != null) {
                if (err.data != null) {
                  if (err.statusCode == 304) {
                    log.d('data has no changes since $lastReadTime');
                  }
                } else {
                  log.e('SEVER RESPONSE DATA IS NULL');
                }
              } else {
                log.e('SEVER RESPONSE NULL');
              }
              break;
            default:
              log.i('Default');
          }
        });
        // log.i('After: ' + DateTime.now().toString());
        await Future.delayed(
            const Duration(
              seconds: 7,
            ), () {});
        // log.i('End: ' + DateTime.now().toString());
      }else{
        log.d('watcher is sleeping!');
        await Future.delayed(
        const Duration(
          seconds: 7,
        ), () {});
      }
    }
  }

  void _scrollListener() =>
      flex(_scrollController.position.pixels > 59 ? true : false);
}