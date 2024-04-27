import 'package:flutter/material.dart';
import 'package:proj/SignIn.dart';
import 'package:proj/WelcomePage.dart';
import 'package:proj/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The context here includes a Navigator because it's within the MaterialApp widget.
    return MaterialApp(
      title: 'AsianFood',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The context here is valid for Navigator operations.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.fastfood), // This is your logo placeholder.
              SizedBox(height: 50),
              Text(
                'AsianFood',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 120),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookAndOrderPage()),
                  );
                },
                style: ElevatedButton.styleFrom(),
                child: Text('Begin'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text('Already a member? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
