import 'package:cardguessgame/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  ///Load resources
  final AudioCache player = AudioCache(prefix: 'assets/audio/');
  player.loadAll(['bgm_1.mp3','bgm_2.mp3','bgm_3.mp3','start.mp3','about.mp3','help.mp3','y.mp3','n.mp3']);

  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: ''),
    );
  }
}
