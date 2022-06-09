import 'package:flutter/material.dart';

class scoreDisplay extends StatelessWidget {
  final int gameScore;

  scoreDisplay(this.gameScore);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
      ),
      child: Text('SCORE: $gameScore', style: const TextStyle(color: Colors.black, fontSize: 20,),textDirection: TextDirection.rtl,
      ),
    );
  }
}
