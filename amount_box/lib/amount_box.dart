library amount_box;

import 'package:flutter/material.dart';

import 'background/water_shape.dart';

class AmountBox extends StatelessWidget {
  final String name;
  final String amount;
  final String roleText;
  final VoidCallback callback;
  final TextStyle style;
  final TextStyle rolestyle;
  final Color roleBackgroundColor;
  final Color roleTextColor;
  const AmountBox({
    required this.name,
    required this.amount,
    required this.callback,
    this.style = const TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
    this.rolestyle = const TextStyle(fontSize: 10),
    this.roleBackgroundColor = const Color.fromRGBO(213, 245, 227, 1),
    this.roleTextColor = const Color.fromRGBO(254, 155, 75, 1),
    required this.roleText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 140,
      margin: const EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 0.0),
      decoration: BoxDecoration(
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
                  name.toString(),
                  style: style,
                ),
                Text(
                  //MMK
                  amount.toString(),
                  style: style,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                    color: roleBackgroundColor,
                    borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.center,
                child: Text(
                  roleText,
                  style: TextStyle(
                    color: roleTextColor,
                  ),
                ),
              ),
              InkWell(
                onTap: callback,
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
