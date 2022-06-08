import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cardguessgame/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  ///Load resources
  final AudioCache cache = AudioCache(prefix: 'assets/audio/');
  cache.loadAll([
    'bgm_1.mp3',
    'bgm_2.mp3',
    'bgm_3.mp3',
    'button_start.mp3',
    'button_help.mp3',
    'button_about.mp3',
    'button_home.mp3',
    'button_y.mp3',
    'button_n.mp3',
    'button_high.mp3',
    'button_low.mp3',
    'button_equal.mp3',
    'answer_correct.mp3',
    'answer_wrong.mp3'
  ]);
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  FadeRoute(
                      page: MyHomePage(
                    title: '',
                  )));
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                'Tap to begin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
