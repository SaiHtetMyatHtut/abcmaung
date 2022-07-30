import 'package:abc_maung/constants/abcicon.dart';
import 'package:abc_maung/constants/theme_color.dart';
import 'package:abc_maung/controller/tab_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBarController _controller = Get.find();
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 0)
      ]),
      child: DefaultTabController(
        length: 3,
        child: Obx(() {
          var curIndex = _controller.index.value;
          return TabBar(
            controller: _controller.tabController,
            indicator: BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
              border: Border.all(width: 5, color: Colors.white),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 0)
              ],
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Center(
                  child: Icon(
                    Abctabbar.menu,
                    color: curIndex == 0 ? Colors.white : ThemeColors.darkGreen,
                    size: curIndex == 0 ? 18 : 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Center(
                  child: Icon(
                    Abctabbar.wallet,
                    color: curIndex == 1 ? Colors.white : ThemeColors.darkGreen,
                    size: curIndex == 1 ? 18 : 24,
                  ),
                ),
              ),
              Center(
                child: Icon(
                  Abctabbar.user,
                  color: curIndex == 2 ? Colors.white : ThemeColors.darkGreen,
                  size: curIndex == 2 ? 18 : 24,
                ),
              )
            ],
            onTap: (index) {
              _controller.setIndex(index);
            },
          );
        }),
      ),
    );
  }
}
