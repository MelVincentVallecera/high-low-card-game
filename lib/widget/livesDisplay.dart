import 'package:flutter/material.dart';

class livesDisplay extends StatelessWidget {
  final int gameLives;

  livesDisplay(this.gameLives);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Text('Lives: $gameLives', style: const TextStyle(color: Colors.red, fontSize: 20,),textDirection: TextDirection.rtl,
      ),
    );
  }
}