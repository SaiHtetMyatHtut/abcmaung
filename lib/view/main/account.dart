import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/lang/localization_service.dart';
import 'package:abc_maung/model/auth/session_request.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:abc_maung/view/widgets/app_bar/navbar_container.dart';
import 'package:abc_maung/view/widgets/load.dart';
import 'package:flutter/material.dart';
import 'package:abc_maung/view/widgets/custom_slide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);
  final Logger logger = Logger();
  final Controller _ctrl = Get.find();
  final LocalizationService _local = Get.find();
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  void logout() {
    Load();
    SessionReg session = SessionReg(_ctrl.userId,_ctrl.token);
    ApiService(Dio())
    .deleteSession(session)
    .then((value){
      if (value.status == 0) {
        // TODO: go login page
        _ctrl.setLogin(false);
        _ctrl.setToken('');
        Get.back();
        Get.offNamed('/login',arguments: {
            'userPhone':_ctrl.userPhone
          });
      }
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          Get.back();
          logger.d(errorResponse.codeMsg);
          break;
        default:
      }
    });
  }

  void record(){
    Get.toNamed('/account/record');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                toolbarHeight: 68.0,
                // expandedHeight: 242.0, //note
                elevation: 2.0,
                title: Container(
                    height: 60.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      // TODO: change DEC31
                      'abc Maung',
                      // _ctrl.fullName,
                    style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen),
                  )
                ),
                floating: true,
                pinned: true,
                // backgroundColor: ThemeColors.lightGreen,
                backgroundColor: Colors.white,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 17.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: DropdownButton(
                        underline: Container(),
                        // icon: const Icon(Icons.arrow_drop_down),
                        value: _local.current,
                        items: LocalizationService.langs.map((String lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang,
                              style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen),
                            ));
                        }).toList(),
                        onChanged: (value) {                
                          _local.changeLocale(value.toString());
                        },
                      ),
                    )
                  ),
                ]
              ),
              // balance(),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              display(
                onTab: (){},
                icon: Icons.money,
                title: 'Balance',
                trail: '${_ctrl.mainBalance.toString()} MMK'
              ),
              display(icon: Icons.mail, title: 'Username', trail: _ctrl.fullName,onTab: (){}),
              display(icon: Icons.receipt, title: 'Record', trail: '',onTab: record),
              display(icon: Icons.lock, title: 'Password', trail: '',onTab: (){}),
              language(icon: Icons.language, title: 'Language',),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.0,
                ),
              ),
              logoutSlider(
                onConfirm: () => logout(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 200.0,
                ),
              )
            ],
          ),
          NavContainer()
        ],
      ),
    );
  }

  Widget display(
      {required IconData icon,
      required String title,
      required String trail,
      required VoidCallback onTab,
      }) =>
      SliverToBoxAdapter(
        child: GestureDetector(
          onTap: onTab,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: ListTile(
              horizontalTitleGap: -6.0,
              visualDensity: const VisualDensity(horizontal: 0.0, vertical: -3.0),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              title: Text(
                title.tr,
                style: abcStyle(15, FontWeight.bold, Colors.grey),
              ),
              leading: Icon(
                icon,
                color: ThemeColors.lightGreen,
              ),
              trailing: Text(
                trail,
                style: abcStyle(15, FontWeight.normal, Colors.grey),
                // style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
        ),
      );

Widget language(
      {required IconData icon,
      required String title,
      }) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: ListTile(
            horizontalTitleGap: -6.0,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -3.0),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            title: Text(
              title.tr,
              style: abcStyle(15, FontWeight.bold, Colors.grey),
            ),
            leading: Icon(
              icon,
              color: ThemeColors.lightGreen,
            ),
            trailing: DropdownButton(
              underline: Container(),
              // icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: Colors.grey,
              // style: abcStyle(15, FontWeight.bold, Colors.grey),
              style: TextStyle(color: Colors.grey),
              focusColor: Colors.grey,
              value: _local.current,
              dropdownColor: ThemeColors.white,
              items: LocalizationService.langs.map((String lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(
                    lang,
                    style: abcStyle(14, FontWeight.normal, Colors.grey),
                  ));
              }).toList(),
              onChanged: (value) {                
                _local.changeLocale(value.toString());
              },
            ),
          ),
        ),
      );

  Row accountInfo() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30, right: 20),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/account/photo.png'))),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //name
                _ctrl.fullName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              //MMK
              Text('${_ctrl.mainBalance.toString()} MMK',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.lightGreen,
                    fontSize: 18,
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget logoutSlider({
    required Function onConfirm,
  })=>SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: InkWell(
        onLongPress: () => onConfirm(),
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 204, 113, 1),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Stack(children: [
            Text(
              'Sign Out'.tr,
              style: abcStyle(18.0, FontWeight.bold, Colors.white),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Icon(
                  Icons.logout,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ],mainAxisAlignment: MainAxisAlignment.end,)
          ],alignment: Alignment.center,),
        ),
      ),
    ),
  );

  // Widget logoutSlider({required Function onConfirm, required double width}) {
  //   return SliverToBoxAdapter(
  //     child: InkWell(
  //       // onLongPress: (){print('logout');},
  //       onLongPress: () => onConfirm(),
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
  //         child: ConfirmationSlider(
  //           onConfirmation: () => onConfirm(),
  //           height: 50.0,
  //           width: width,
  //           backgroundColor: const Color.fromRGBO(213, 245, 227, 1),
  //           // backgroundColorEnd: Colors.red,
  //           foregroundColor: const Color.fromRGBO(46, 204, 113, 1),
  //           backgroundShape: BorderRadius.circular(10.0),
  //           foregroundShape: BorderRadius.circular(10.0),
  //           shadow: const BoxShadow(
  //             color: Colors.transparent,
  //             offset: Offset(0, 0),
  //             blurRadius: 2,
  //             spreadRadius: 0,
  //           ),
  //           sliderButtonContent: const Icon(
  //             Icons.logout,
  //             size: 30.0,
  //             color: Colors.white,
  //           ),
  //           text: 'Sign Out',
  //           textStyle: GoogleFonts.poppins(
  //               fontSize: 14.0,
  //               fontWeight: FontWeight.bold,
  //               color: const Color.fromRGBO(46, 204, 113, 1)),
  //           stickToEnd: true,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
