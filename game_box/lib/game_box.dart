library game_box;

import 'package:flutter/material.dart';

class TwodContainer extends StatelessWidget {
  final String title;
  final TextStyle titledec;
  final String content;
  final TextStyle contentdec;
  final VoidCallback callback;
  final AssetImage boxImage;
  const TwodContainer(
    this.title,
    this.content,
    this.callback,
    this.boxImage, {
    this.titledec = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    this.contentdec = const TextStyle(fontSize: 12),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(image: boxImage, fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 2),
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
                      Text(title, style: titledec),
                      Text(
                        content,
                        style: contentdec,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
