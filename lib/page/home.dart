import 'package:flutter/material.dart';
import 'package:cardguessgame/page/game.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future openDialogHelp() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Play',textAlign: TextAlign.center),
        content: const Text(
            'A card is shown and you has to guess if\nthe next card is > or < the current card.\nIf the you guess correctly, you get points.\nIf you get it wrong, the game ends',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
  );

  Future openDialogInfo() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('About',textAlign: TextAlign.center,),
      content: const Text('This app was made by Team10.\nMembers:\nStephen Abueva\nJoanah Mae Bulabos\nMelanie Orot\nMel Vincent Vallecera',textAlign: TextAlign.center,),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );

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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, FadeRoute(page: GamePage()));
                        },
                        child: Image.asset(
                          'assets/ui/play.png',
                          scale: 4.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          openDialogHelp();
                        },
                        child: Image.asset(
                          'assets/ui/help.png',
                          scale: 5.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          openDialogInfo();
                        },
                        child: Image.asset(
                          'assets/ui/about.png',
                          scale: 5.0,
                        ),
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
