import 'package:flutter/material.dart';
import 'package:cardguessgame/page/game.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:animated_button/animated_button.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioCache player = AudioCache();

  Future openDialogHelp() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Play',textAlign: TextAlign.center),
        content: const Text('A card is shown and you have to guess if the\nnext card is >, < or = to the current card.\nIf you guess correctly, you get points.\nIf you get it wrong, the game ends', textAlign: TextAlign.center,),
        actions: [
          Center(
            child: TextButton(
              child: const Text('Ok'),
              onPressed: () {
                player.play('button_y.mp3');
                Navigator.pop(context);
                },
            ),
          ),
        ],
      ),
  );

  Future openDialogInfo() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('About',textAlign: TextAlign.center,),
      content: const Text('This app was made by\nMel Vincent Vallecera\nBSCpE 3B',textAlign: TextAlign.center,),
      actions: [
        Center(
          child: TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              player.play('button_y.mp3');
              },
          ),
        ),
      ],
    ),
  );
  @override
  void initState() {
    super.initState();
    player.loop('bgm_1.mp3');

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to exit')),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundloop.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/ui/logo.png',
                    ),
                    scale: 3.0,
                    alignment: Alignment(-0.005, -0.6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(height: 50,),
                      AnimatedButton(
                        width: 100,
                        color: Colors.transparent,
                        onPressed: () {player.play('button_start.mp3');
                          Navigator.pushReplacement(context, FadeRoute(page: GamePage()));},
                        child: Image.asset('assets/ui/play.png', scale: 4.0,),
                      ),

                      const SizedBox(height: 10,),
                      AnimatedButton(
                        width: 100,
                        color: Colors.transparent,
                        onPressed: () {player.play('button_help.mp3');
                          openDialogHelp();},
                        child: Image.asset('assets/ui/help.png', scale: 5.0,),
                      ),

                      const SizedBox(height: 10,),
                      AnimatedButton(
                        width: 100,
                        color: Colors.transparent,
                        onPressed: () {player.play('button_about.mp3');
                          openDialogInfo();},
                        child: Image.asset('assets/ui/about.png', scale: 6.0,),
                      ),
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

class FadeRoute extends PageRouteBuilder {
  //custom fade animation to use when switching pages
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
