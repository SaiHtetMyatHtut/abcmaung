import 'package:flutter/material.dart';

class GameType extends StatefulWidget {
  final String gamename;
  final Function onTap;
  const GameType({
    Key? key,
    required this.gamename,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GameType> createState() => _GameTypeState();
}

class _GameTypeState extends State<GameType> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/200'))),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Text(
              widget.gamename,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
