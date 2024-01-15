import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/ui/quran.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer? _timer;
  int _second = 5; // set timer for 3 second and then direct to next page
  late ScaffoldMessengerState scaffoldMessenger;

  void _startTimer() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainQuranPage()),
            (Route<dynamic> route) => false);
        _cancelFlashSaleTimer();
      }
    });
  }

  void _cancelFlashSaleTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    if (_second != 0) {
      _startTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashSaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("$LOCAL_IMAGES_URL/background.jpeg"),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height - 50,
                child: SingleChildScrollView(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                              duration: const Duration(milliseconds: 2500),
                              child: SlideAnimation(
                                  duration: const Duration(milliseconds: 1000),
                                  child: FadeInAnimation(
                                      child: Image.asset(
                                    "$LOCAL_IMAGES_URL/logo.png",
                                    width: size.width * 0.75,
                                  ))))),
                      const SizedBox(height: 10),
                      const Text(
                        "Quran dan Sholat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IsepMisbah'),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0, -10, 0),
                        child: const Column(
                          children: [
                            Text(
                              "Petunjuk Bagi Mereka yang Bertakwa",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Lobster'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            )));
  }
}
