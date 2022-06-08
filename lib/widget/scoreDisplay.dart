import 'package:flutter/material.dart';

class scoreDisplay extends StatelessWidget {
  final int gameScore;

  scoreDisplay(this.gameScore);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
      ),
      child: Text('SCORE:           $gameScore', style: const TextStyle(color: Colors.black, fontSize: 25,),textDirection: TextDirection.rtl,
      ),
    );
  }
}
