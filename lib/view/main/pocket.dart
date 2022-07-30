import 'package:abc_maung/constants/data.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:abc_maung/lang/localization_service.dart';
import 'package:abc_maung/view/widgets/app_bar/navbar_container.dart';
import 'package:abc_maung/view/widgets/background_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class Pocket extends StatelessWidget {
  Pocket({Key? key}) : super(key: key);
  final Controller _ctrl = Get.find();
  final LocalizationService _local = Get.find();
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  void transaction(){
    Get.toNamed('/transaction');
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double _padding = width * (0.17);
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                toolbarHeight: 68.0,
                expandedHeight: 250.0,
                elevation: 2,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 75.0, 30.0, 0.0),
                      child: Stack(children: [
                        Container(
                          height: 30.0,
                          alignment: Alignment.centerLeft,
                          child: const Icon(Icons.volume_up),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 30.0),
                          height: 30.0,
                          alignment: Alignment.centerLeft,
                          child: Marquee(
                            text: '            abcMaung မှကြေငြာချက်များ',
                            style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen.withOpacity(0.7)),
                            velocity: 20.0,
                          ),
                        )
                      ],)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: transaction,
                        child: moneyContainer(context),
                      ),
                    ),
                  ],)
                ),
                title: Container(
                    height: 68.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      // TODO: change DEC31
                      'abc Maung',
                      // _ctrl.fullName,
                    style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen),
                  )),
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
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 25.0, 0.0, 0.0),
                child: Text(
                  'Avaliable Payment'.tr,
                  style: abcStyle(18, FontWeight.bold, ThemeColors.darkGreen),
                ),
              )),
              body(_padding, PaymentData.paymentData),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 25.0, 0.0, 0.0),
                child: Text(
                  'Avaliable Widraw'.tr,
                  style: abcStyle(18, FontWeight.bold, ThemeColors.darkGreen),
                ),
              )),
              body(_padding, WithdrawData.withdrawData),
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

  Widget body(double _padding, List data) => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(_padding, 22.0, _padding, 0.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: _padding,
                  mainAxisSpacing: 20.0),
              shrinkWrap: true,
              primary: false,
              itemCount: data.length,
              itemBuilder: (context, index) => payment(
                  url: data[index]['url'],
                  title: data[index]['title'],
                  onTab: data[index]['onTab'])),
        ),
      );
  Widget payment(
      {required String url, required String title, required Function onTab}) {
    return GestureDetector(
      onTap: () {
        onTab();
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(image: AssetImage(url))),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            title.tr,
            style: abcStyle(14, FontWeight.bold, ThemeColors.darkGreen),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Container moneyContainer(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 3.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 2.0,
            offset: const Offset(2, 2)
          )
        ],
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Stack(children: [
        CustomPaint(
          size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 0.2598870056497175)
                  .toDouble()),
          painter: RPSCustomPainter(),
        ),
        moneyinfo(),
      ]),
    );
  }

  Padding moneyinfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _ctrl.fullName,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  //MMK
                  '${_ctrl.mainBalance.toString()} MMK',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 20,
                color: ThemeColors.glass,
                child: Text(
                  'VIP-1'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.gold),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color.fromRGBO(254, 155, 75, 1),
                    ),
                    child: const Icon(
                      Icons.forward,
                      size: 16,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
