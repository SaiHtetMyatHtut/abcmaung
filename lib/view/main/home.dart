import 'package:abc_maung/constants/data.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/view/main/carousel.dart';
import 'package:abc_maung/view/widgets/app_bar/navbar_container.dart';
import 'package:get/get.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class Home extends StatelessWidget {
  final Controller _ctrl = Get.find();
  Home({ Key? key }) : super(key: key);
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );
  @override
  Widget build(BuildContext context) {
    // testing
    _ctrl.setUserId('testuser#0000');
    _ctrl.setWalletId('7a998487-a9be-452f-8cee-9d798fa04e4a');
    // testing
    return SafeArea(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                expandedHeight: 250.0,
                toolbarHeight: 68.0,
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

                    ABCCarousel(
                      intervel: 5000,
                      speed: 2000,
                      edgeInsets: const EdgeInsets.fromLTRB(0.0, 110.0, 0.0, 0.0),
                      children: const[
                        AssetImage('assets/home/carousel.png'),
                        AssetImage('assets/home/carousel2.png'),
                        AssetImage('assets/home/carousel3.png'),
                        AssetImage('assets/home/carousel4.png'),
                      ]
                    )
                  ],)
                ),
                title: Container(
                  height: 68.0,
                  margin: const EdgeInsets.only(left: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'abc Maung'.tr,
                  style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen),
                )),
                floating: true,
                pinned: true,
                // backgroundColor: ThemeColors.lightGreen,
                backgroundColor: Colors.white,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                        _ctrl.mainBalance.toString()+ ' MMK'.tr,
                        style: abcStyle(14, FontWeight.normal, ThemeColors.darkGreen),
                      ),
                    )
                  ),
                ]
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 25.0, 0.0, 0.0),
                child: Text(
                  'Games'.tr,
                  style: abcStyle(18,FontWeight.w700, ThemeColors.darkGreen)
                ),
              )),
              body(),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100.0,
                ),
              )
            ],
          ),
          NavContainer()
        ],)
      );
  }
  Widget body() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 22.0, 30.0, 0.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0),
            shrinkWrap: true,
            primary: false,
            itemCount: GameItems.items.length,
            itemBuilder: (context, index) => cart(
              url: GameItems.items[index]['url'],
              title: GameItems.items[index]['title'],
              centerTitle: GameItems.items[index]['centerTitle'],
              context: GameItems.items[index]['context'],
              onTap: GameItems.items[index]['onTap'],
            ),
          ),
        ),
      );
  Widget cart(
          {required String url,
          required String title,
          required bool centerTitle,
          required String context,
          required Function onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0,right: 3.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                  )
                ]),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    width: 167,
                    height: 84,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            title.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            context.tr,
                            style: GoogleFonts.poppins(fontSize: 12),
                            overflow: TextOverflow.clip,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}