import 'package:abc_maung/view/widgets/abc_appbar.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: abcAppBar(title: 'How To Play!', actions: []),
      body: Center(
        child: Image.asset('assets/home/3d_game.png'),
      ),
    );
  }
}