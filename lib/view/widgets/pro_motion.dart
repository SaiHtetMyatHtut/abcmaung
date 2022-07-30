import 'package:flutter/material.dart';

class Promo extends StatelessWidget {
  const Promo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.pinkAccent,
        // image: const DecorationImage(
        //     image: NetworkImage('https://picsum.photos/300')),
      ),
    );
  }
}
