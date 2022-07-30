library payment_box;

import 'package:flutter/material.dart';

class PaymentBox extends StatelessWidget {
  final AssetImage url;
  final VoidCallback callback;
  const PaymentBox(
    this.url, {
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black12),
        ),
        child: Container(
          margin: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(image: url, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
