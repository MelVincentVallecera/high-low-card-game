import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cardguessgame/firebase_options.dart';
import 'package:cardguessgame/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///Set preferred orientation for device, in this case portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  ///Load resources
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ///Loads mp3 files to be used in the app
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
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// dialog box to ask user for their name to be used when submitting scores to firebase for highscores
  Future openDialogName() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Your Name', textAlign: TextAlign.center),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.account_circle_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter name';
            }
            return null;
          },
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            child: const Text('Submit'),
            onPressed: () {setState(() {
              if(_formKey.currentState!.validate()) {
                submitName();
                Navigator.pushReplacement(
                    context,
                    FadeRoute(
                        page: MyHomePage(
                          title: '',
                        )));
              }
            });
            },
          ),
        ),
      ],
    ),
  );
 /// uses sharedpreference package to store user's name
  void submitName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); ///clears previous user's name stored
    prefs.setString("name", _nameController.text);
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
          ///when user taps the screen, it opens a dialog box
          GestureDetector(
            onTap: () {
              openDialogName();
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
