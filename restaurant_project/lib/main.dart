import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/recipe_provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_project/screens/auth/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'AsianFood',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInPage(),
      ),
    );
  }
}
