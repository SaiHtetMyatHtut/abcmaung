import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/model/transaction/cashin_both.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/pocket/amount_suggest.dart';
import 'package:abc_maung/view/widgets/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:get/get.dart';
// ignore_for_file: invalid_use_of_protected_member
// ignore: must_be_immutable
class Deposit extends StatelessWidget {
  Deposit({Key? key}) : super(key: key);
  final argu = Get.arguments;
  Controller _ctrl = Get.find();
  final _lctrl = Get.put(DepositController());
  late String url;
  late String method;
  TextEditingController _amount = TextEditingController();
  TextEditingController _transferTo = TextEditingController();
  TextEditingController _lastPh4 = TextEditingController();
  TextEditingController _lastTran6 = TextEditingController();
  void btnContinue() {
    int amount = _amount.text==''? 0: int.parse(_amount.text);
    String transferTo = _transferTo.text;
    String lastPh4 = _lastPh4.text;
    String lastTran6 = _lastTran6.text;
    
    if(amount>0 && transferTo!='' && lastPh4.length==4 && lastTran6.length==6){
      ToCashIn toCashIn = ToCashIn(
        userId: _ctrl.userId,
        amount: amount,
        lastPh4: lastPh4,
        lastTran6: lastTran6,
        transferTo: transferTo,
        paymentMethod: method
      );
      ApiService(Dio())
      .cashIn(toCashIn)
      .then((value){
        print(value.message);
        Get.offNamed('/depositdetail', arguments: {
          'deposit_amt': value.amount,
          'date': value.date,
          'name': _ctrl.fullName,
          'transaction_id': value.tranId
        });
      })
      .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            ErrorResponse errorResponse = ErrorResponse(obj: obj);
            Get.snackbar('ERROR ${errorResponse.code}', errorResponse.codeMsg,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 5));
            break;
          default:
        }
      });
      
    }else if(amount==0){
      error('Error','Transfered Ammount?');
    }else if(transferTo==''){
      error('Error','Transfered Phone?');
    }else if(lastPh4.length!=4){
      error('Error','Last 4 digit?');
    }else if(lastTran6.length!=6){
      error('Error','Last 6 digit?');
    }

  }

  @override
  Widget build(BuildContext context) {
    url = argu['url'];
    method = argu['method'];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 26,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.greenAccent),
          backgroundColor: ThemeColors.white,
          elevation: 0,
          title: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                clicktoback(),
                Text(
                  'Transfer'.tr,
                  style: GoogleFonts.poppins(
                      color: ThemeColors.lightGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        body: buildlayout(url),
        bottomNavigationBar: navbar(),
      ),
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
      );

  Widget buildlayout(String url) => Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
      child: ListView(
        children: [
          kpaybox(url),
          const SizedBox(height: 50),
          Row(children: [
            Expanded(
              flex: 13,
              child: Container(
                height: 70.0,
                child: ElevatedButton(
                  onPressed: ()=> _lctrl.isDrop(!_lctrl.isDrop.isTrue),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(213, 245, 227, 1),
                    shadowColor: null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0,right: 0.0),
                    child: Row(children: [
                      Column(children: [
                        Text('Transfer to'.tr,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.lightGreen, fontSize: 17
                          ),
                        ),
                        Obx( ()=>
                        Text(_lctrl.currentPhone.value,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.lightGreen, fontSize: 17
                          ),
                        ))
                      ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,),
                      Icon(Icons.keyboard_arrow_down,size: 40.0,color: Color.fromRGBO(46, 204, 113, 1),)
                    ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                  ),
                ),
              )
            ),
            // Expanded(
            //   flex: 13,
            //   child: InkWell(
            //     onTap: ()=> _lctrl.isDrop(!_lctrl.isDrop.isTrue),
            //     child: Container(
            //       height: 70.0,
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(213, 245, 227, 1),
            //         borderRadius: BorderRadius.circular(5.0),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.6),
            //             offset: Offset(1,1)
            //           )
            //         ]
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 25.0,right: 20.0),
            //         child: Row(children: [
            //           Column(children: [
            //             Text('Transfer to',
            //               style: GoogleFonts.poppins(
            //                 color: ThemeColors.lightGreen, fontSize: 18
            //               ),
            //             ),
            //             Obx( ()=>
            //             Text(_lctrl.currentPhone.value,
            //               style: GoogleFonts.poppins(
            //                 color: ThemeColors.lightGreen, fontSize: 18
            //               ),
            //             ))
            //           ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,),
            //           Icon(Icons.keyboard_arrow_down,size: 40.0,color: Color.fromRGBO(46, 204, 113, 1),)
            //         ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
            //       ),
            //     ),
            //   )
            // ),
            SizedBox(width: 7.0,),
            Expanded(
              flex: 4,
              child: 
              Container(
                height: 70.0,
                child: ElevatedButton(
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: _lctrl.currentPhone.value));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(213, 245, 227, 1),
                    shadowColor: null,
                  ),
                  child: Icon(Icons.file_copy,size: 40.0,color: Color.fromRGBO(46, 204, 113, 1),),
                ),
              )
              
            )
          ],),
          // Text(
          //   'Transfer Phone Number',
          //   style: GoogleFonts.poppins(
          //       color: ThemeColors.lightGreen, fontSize: 16),
          // ),
          // transferPh(_transferTo),
          // const SizedBox(height: 20),
          Obx( ()=>
          OverlayContainer(
            show: _lctrl.isDrop.isTrue,
            child: Container(
              width: (Get.width-67)*0.764705,
              height: 112.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(213, 245, 227, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: Offset(1,1)
                  )
                ]
              ),
              child: Column(children: List.generate(2, (i) => 
                InkWell(
                  onTap: (){
                    _lctrl.currentPhone(_lctrl.phone.value[i]);
                    _lctrl.isDrop(false);
                    _transferTo.text=_lctrl.phone.value[i];
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 25.0),
                    leading: Text(
                      _lctrl.phone.value[i],
                      style: GoogleFonts.poppins(
                        color: ThemeColors.lightGreen, fontSize: 16,
                        fontWeight: _lctrl.phone.value[i]==_lctrl.currentPhone.value?
                          FontWeight.bold:FontWeight.normal
                      ),
                    ),
                  ),
                )
              )
              ,),
             
            ),
          ),),
          SizedBox(height: 20.0,),
          Text(
            'Transfered Amount'.tr,
            style: GoogleFonts.poppins(
                color: ThemeColors.lightGreen, fontSize: 16),
          ),
          // test
          SuggestField(
            amount: _amount,
          ),
          Text(
            'Last 4 Digit of Phone Number'.tr,
            style: GoogleFonts.poppins(
                color: ThemeColors.lightGreen, fontSize: 16),
          ),
          fourdigit(_lastPh4),
          const SizedBox(height: 20),
          Text(
            'Last 6 Digit of Transaction'.tr,
            style: GoogleFonts.poppins(
                color: ThemeColors.lightGreen, fontSize: 16),
          ),
          sixdigit(_lastTran6),
          const SizedBox(height: 17),
        ],
      ),
    );

Widget clicktoback() => Container(
      margin: const EdgeInsets.only(right: 15, left: 35),
      child: Icon(
        Icons.arrow_back_sharp,
        color: ThemeColors.lightGreen,
      ),
    );

Widget kpaybox(String url) => Container(
      width: 355,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          height: 89,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(url)),
          ),
        ),
      ),
    );

Widget transferPh(TextEditingController transferTo) => TextFormField(
  controller: transferTo,
  keyboardType: TextInputType.number,
  cursorHeight: 22,
  decoration: InputDecoration(
    suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    hintText: "09777888999",
    hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
  ),
);

Widget fourdigit(TextEditingController lastPh4) => TextFormField(
  controller: lastPh4,
  keyboardType: TextInputType.number,
  cursorHeight: 22,
  maxLength: 4,
  decoration: InputDecoration(
    suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    hintText: "1234",
    hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
  ),
);

Widget sixdigit(TextEditingController lastTran6) => TextFormField(
  controller: lastTran6,
  keyboardType: TextInputType.number,
  cursorHeight: 22,
  maxLength: 6,
  decoration: InputDecoration(
    suffixStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    hintText: "123456",
    hintStyle: GoogleFonts.poppins(color: ThemeColors.lightGreen),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ThemeColors.lightGreen, width: 2),
    ),
  ),
);

}

class DepositController extends GetxController {
  RxBool isDrop = false.obs;
  RxList phone = [].obs;
  RxString currentPhone = 'Please Select'.obs;
  @override
  void onInit() {
    List tmp = [];
    tmp.add('+959755386957');
    tmp.add('+959780132792');
    phone(tmp);
    // phone(List.generate(2,
    //  (i) => 'Please Wait')
    // );
    super.onInit();
  }
}

class OverlayContainer extends StatefulWidget {
  /// The child to render inside the container.
  final Widget child;

  /// By default, the child will be rendered right below (if the parent is `Column`)
  /// the widget which is defined alongside the OverlayContainer.
  /// It would appear as though the Overlay is inside its parent
  /// but in reality it would be outside and above
  /// the original widget hierarchy.
  /// It's position can be altered and the overlay can
  /// be moved to any part of the screen by supplying a `position`
  /// argument.
  final OverlayContainerPosition position;

  /// Controlling whether the overlay is current showing or not.
  final bool show;

  /// Whether the overlay is wide as its enclosing parent.
  final bool asWideAsParent;

  /// `color` attribute for the `Material` component that wraps `child`.
  final Color materialColor;

  OverlayContainer({
    required this.show,
    required this.child,
    this.asWideAsParent = false,
    this.position = const OverlayContainerPosition(0.0, 0.0),
    this.materialColor = Colors.transparent,
  });

  @override
  _OverlayContainerState createState() => _OverlayContainerState();
}

class _OverlayContainerState extends State<OverlayContainer>
    with WidgetsBindingObserver {
  late OverlayEntry _overlayEntry;
  bool _opened = false;

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      _show();
    }
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    // We would want to re render the overlay if any metrics
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We would want to re render the overlay if any of the dependencies
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didUpdateWidget(OverlayContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void dispose() {
    if (widget.show) {
      _hide();
    }
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _show() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 280));
      if (_opened) {
        _overlayEntry.remove();
      }
      _overlayEntry = _buildOverlayEntry(context);
      Overlay.of(context)!.insert(_overlayEntry);
      _opened = true;
    });
  }

  void _hide() {
    if (_opened) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _overlayEntry.remove();
        _opened = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in media query such as when a device orientation changes
    // or when the keyboard is toggled.
    MediaQuery.of(context);
    return Container();
  }

  OverlayEntry _buildOverlayEntry(context) {
    RenderBox renderBox = context.findRenderObject();
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx + widget.position.left,
          top: offset.dy - widget.position.bottom,
          width: widget.asWideAsParent ? size.width : null,
          child: Material(
            child: widget.child,
            color: widget.materialColor,
          ),
        );
      },
    );
  }
}

/// Class to help position the overlay on the screen.
/// By default it will be rendered right below (if the parent is `Column`)
/// the widget which is alongside the OverlayContainer.
/// The Overlay can however be moved around by giving a left value
/// and a bottom value just like in the case of a `Positioned` widget.
/// The default values for `left` and `bottom` are 0 and 0 respectively.
class OverlayContainerPosition {
  final double left;
  final double bottom;

  const OverlayContainerPosition(this.left, this.bottom);
}