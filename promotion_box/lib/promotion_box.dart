library promotion_box;

import 'package:flutter/material.dart';

class PromotionBox extends StatelessWidget {
  final AssetImage boximage;
  const PromotionBox(this.boximage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 0.0),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: boximage,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 2),
            )
          ],
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
