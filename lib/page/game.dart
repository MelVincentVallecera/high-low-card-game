import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animated_button/animated_button.dart';
import 'package:cardguessgame/page/value.dart';
import 'package:cardguessgame/page/home.dart';
import 'package:cardguessgame/widget/flip_card_widget.dart';
import 'package:cardguessgame/widget/scoreDisplay.dart';
import 'package:audioplayers/audioplayers.dart';

var card = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'K', 'Q'];
var value = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache(prefix: 'assets/audio/');

  var guessCard;
  var guessCardType;
  var currentCard;
  var currentCardType;
  var lastCard1;
  var lastCard1Type;
  var lastCard2;
  var lastCard2Type;
  var lastCard3;
  var lastCard3Type;
  var lastCard4;
  var lastCard4Type;
  var lastCard5;
  var lastCard5Type;
  var gameScore = 0;
  final controller = FlipCardController();

  void pushToSlot() {
    // function to push values between previous cards
    lastCard5 = lastCard4;
    lastCard5Type = lastCard4Type;
    lastCard4 = lastCard3;
    lastCard4Type = lastCard3Type;
    lastCard3 = lastCard2;
    lastCard3Type = lastCard2Type;
    lastCard2 = lastCard1;
    lastCard2Type = lastCard1Type;
    lastCard1 = currentCard;
    lastCard1Type = currentCardType;
    currentCard = guessCard;
    currentCardType = guessCardType;
    rollGuess();
  }

  void rollGuess() {
    guessCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    guessCardType = Value().cardType[Random().nextInt(Value().cardType.length)];
  }

  void _playLoop() async {
    player = await cache.loop('bgm_2.mp3');
  }

  void _stopLoop() {
    player?.stop();
  }

  charToInt(var input) {
    //function to get int value of card by matching the beginning char of the card
    var output = 0;
    for (int i = 0; i < 13; i++) {
      if (input.startsWith(card[i])) {
        output = value[i];
        return output;
      }
    }
  }

  Future openDialogMenu() => showDialog(
        //Alert Dialog that displays when the home button on the app bar or the physical back button
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Menu',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          content: const Text(
            'Exit the current game?',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    cache.play('button_n.mp3');
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    cache.play('button_y.mp3');
                    _stopLoop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        FadeRoute(page: const MyHomePage(title: '')),
                        (route) => false);
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        ),
      );

  Future openDialogEnd() => showDialog(
        //Alert Dialog to notify user of lost
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            child: AlertDialog(
              title: const Text(
                'Game Over!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
              content: Text(
                'Your Score:\n$gameScore',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        cache.play('button_n.mp3');
                        _stopLoop();
                        Navigator.pushAndRemoveUntil(
                            context,
                            FadeRoute(
                                page: const MyHomePage(
                              title: '',
                            )),
                            (route) => false);
                      },
                      child: const Text('Home'),
                    ),
                    TextButton(
                        onPressed: () {
                          cache.play('button_y.mp3');
                          _stopLoop();
                          Navigator.pushAndRemoveUntil(context,
                              FadeRoute(page: GamePage()), (route) => false);
                        },
                        child: const Text('Retry')),
                  ],
                ),
              ],
            ),
            onWillPop: () async => false,
          );
        },
      );

  @override
  void initState() {
    super.initState();

    cache.loadAll([
      'bgm_2.mp3',
      'button_high.mp3',
      'button_low.mp3',
      'button_equal.mp3',
      'button_home.mp3',
      'answer_correct.mp3',
      'answer_wrong.mp3',
      'button_y.mp3',
      'button_n.mp3'
    ]);
    _playLoop();

    guessCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    guessCardType = Value().cardType[Random().nextInt(Value().cardType.length)];
    currentCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    currentCardType =
        Value().cardType[Random().nextInt(Value().cardType.length)];

    lastCard1 = "temp";
    lastCard1Type = "Slot";
    lastCard2 = "temp";
    lastCard2Type = "Slot";
    lastCard3 = "temp";
    lastCard3Type = "Slot";
    lastCard4 = "temp";
    lastCard4Type = "Slot";
    lastCard5 = "temp";
    lastCard5Type = "Slot";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WillPopScope(
          // trigger when user presses the physical back button, opens the in-game menu
          onWillPop: () async {
            openDialogMenu();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              //appbar color
              titleSpacing: 0,
              leading: Padding(
                padding: EdgeInsets.only(left: 1),
                child: AnimatedButton(
                  onPressed: () {
                    cache.play('button_home.mp3');
                    openDialogMenu();
                  },
                  //opens the menu dialog if the home button icon is pressed
                  height: 55,
                  width: 55,
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/ui/home.png',
                    scale: 1.0,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: scoreDisplay(gameScore),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
              elevation: 5.0,
            ),
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[500], // background color
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: FlipCardWidget(
                        //flips when you guess incorrectly
                        controller: controller,
                        front: Image.asset(
                            'assets/faces/${guessCard}${guessCardType}.png'),
                        back: Image.asset('assets/faces/backside.png'),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${currentCard}${currentCardType}.png'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard1}${lastCard1Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard2}${lastCard2Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard3}${lastCard3Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard4}${lastCard4Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard5}${lastCard5Type}.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                spacing: 20,
                children: <Widget>[
                  AnimatedButton(
                    height: 75,
                    width: 85,
                    color: Colors.transparent,
                    onPressed: () {
                      setState(
                        () {
                          cache.play('button_high.mp3');
                          if (charToInt(guessCard) > charToInt(currentCard)) {
                            cache.play('answer_correct.mp3');
                            gameScore += 1;
                            pushToSlot();
                          } else {
                            cache.play('answer_wrong.mp3');
                            controller.flipCard();
                            openDialogEnd();
                          }
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/ui/higher.png',
                      scale: 5.0,
                    ),
                  ),
                  AnimatedButton(
                    height: 75,
                    width: 85,
                    color: Colors.transparent,
                    onPressed: () {
                      setState(
                        () {
                          cache.play('button_equal.mp3');
                          if (charToInt(guessCard) == charToInt(currentCard)) {
                            cache.play('answer_correct.mp3');
                            gameScore += 1;
                            pushToSlot();
                          } else {
                            cache.play('answer_wrong.mp3');
                            controller.flipCard();
                            openDialogEnd();
                          }
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/ui/equal.png',
                      scale: 5.0,
                    ),
                  ),
                  AnimatedButton(
                    height: 75,
                    width: 85,
                    color: Colors.transparent,
                    onPressed: () {
                      setState(
                        () {
                          cache.play('button_low.mp3');
                          if (charToInt(guessCard) < charToInt(currentCard)) {
                            gameScore += 1;
                            cache.play('answer_correct.mp3');
                            pushToSlot();
                          } else {
                            cache.play('answer_wrong.mp3');
                            controller.flipCard();
                            openDialogEnd();
                          }
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/ui/lower.png',
                      scale: 5.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
