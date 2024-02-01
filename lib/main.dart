import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Fruits(),
  ));
}

class Fruits extends StatefulWidget {
  const Fruits({Key? key}) : super(key: key);

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> with SingleTickerProviderStateMixin {
  int currentImageNumber = 1;
  String text = nameExtractor(imgList[0]);
  final FlutterTts flutterTts = FlutterTts();

  late double _currentOpacity = 0.0;
  bool animating = false;
  bool timingOn = false;
  final player = AudioPlayer();

  late Timer _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            startAnimating();
            _start = 15;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future startAnimating() async {
    _currentOpacity = 1.0;
    animating = true;
    await player.setAsset('assets/smooth-jazz.mp3');
    await player.play();
  }

  void checkTimer() {
    if (animating != true && timingOn == false) {
      startTimer();
      timingOn = true;
    } else {
      setState(() {
        _start = 15;
      });
    }
  }

  Future _speak() async {
    await flutterTts.getVoices;
    print(flutterTts.getVoices);

    await flutterTts.getLanguages;
    print(flutterTts.getLanguages);
    await flutterTts.speak(text);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});


    await flutterTts.setSpeechRate(0.3);

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.1);
    await flutterTts.setSharedInstance(true);
  }

  @override
  void disposeBar() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFF4fc3f7),
      body: Column(
        children: [
          const SizedBox(height: 65.0),
          Center(
            child: SafeArea(
                child: Text(
              text,
              style: GoogleFonts.averageSans(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
          const SizedBox(height: 54.0),
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _speak();
                  checkTimer();
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 100,
                      minHeight: 200,
                      maxHeight: 380,
                      maxWidth: 420),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      currentImageNumber = index;

                      return Image.asset(
                        imgList[index],
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                        cacheHeight: 380,
                        cacheWidth: 420,
                      );
                    },
                    itemCount: 30,
                    viewportFraction: 1,
                    scale: 0.8,
                    onIndexChanged: (index) {
                      setState(() {
                        text = nameExtractor(imgList[index]);
                        checkTimer();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: AnimatedOpacity(
                opacity: _currentOpacity,
                duration: const Duration(milliseconds: 250),
                child: AnimatedAlign(
                  duration: const Duration(seconds: 7),
                  alignment:
                      animating ? Alignment.bottomRight : Alignment.bottomLeft,
                  curve: Curves.linear,
                  onEnd: () {
                    _currentOpacity = 0.0;
                    animating = false;
                  },
                  child: Lottie.asset(
                    'assets/walking-orange.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
