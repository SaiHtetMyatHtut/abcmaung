import 'package:abc_maung/controller/tab_bar_controller.dart';
import 'package:abc_maung/view/main/home.dart';
import 'package:abc_maung/view/main/pocket.dart';
import 'package:abc_maung/view/widgets/buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'account.dart';

class Main extends StatefulWidget  {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main>  with SingleTickerProviderStateMixin  {
  late TabBarController _mainTab;
  late TabController _tabController;
  TextStyle abcStyle(double size,FontWeight fontWeight,Color color) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color
  );

  final _kTabPages = <Widget>[
      Home(),
      Pocket(),
      Account(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length, vsync: this
    );
    _mainTab = Get.put(TabBarController(tabController: _tabController));
    _tabController.addListener(() {
      if(!_tabController.indexIsChanging){
        _mainTab.setIndex(_tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabPages.length,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
