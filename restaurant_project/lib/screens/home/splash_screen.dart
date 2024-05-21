import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_project/main.dart';
import 'package:restaurant_project/screens/account/profile.dart';
import 'package:restaurant_project/screens/auth/sign_in.dart';
import 'package:restaurant_project/screens/home/welcome_page.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  _updateProgress() async {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _progressValue = 1.0;
          t.cancel();
          _navigateToHome();
        }
      });
    });
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 500), () {}); // Short delay after progress reaches 100%
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/asian_food_logo.jpeg', // Ensure this path is correct
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
