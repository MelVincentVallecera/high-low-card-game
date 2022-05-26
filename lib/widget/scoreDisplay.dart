import 'package:flutter/material.dart';

class scoreDisplay extends StatelessWidget {
  final int gameScore;

  scoreDisplay(this.gameScore);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Text(
        'SCORE: $gameScore',
        style: const TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }
}
