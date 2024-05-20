import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/recipe_provider.dart';
import 'package:restaurant_project/menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_project/sign_in.dart';
import 'package:restaurant_project/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        title: 'AsianFood',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.fastfood),
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
                    MaterialPageRoute(builder: (context) => SplashScreen()),
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
