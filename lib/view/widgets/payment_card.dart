import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  final Function onTap;
  const Payment({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(236, 240, 241, 1),
        ),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/200'))),
        ),
      ),
    );
  }
}
