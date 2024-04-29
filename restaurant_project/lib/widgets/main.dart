import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_project/views/auth/sign_in_page.dart';
import 'package:restaurant_project/views/auth/sign_up_page.dart';
import 'package:restaurant_project/views/auth/forgot_password_page.dart';
import 'package:restaurant_project/views/main/home_page.dart';
import 'package:restaurant_project/views/main/about_us_page.dart';
import 'package:restaurant_project/views/main/profile_page.dart';
import 'package:restaurant_project/views/main/settings_page.dart';
import 'package:restaurant_project/views/menu/menu_page.dart';
import 'package:restaurant_project/views/menu/dish_detail_page.dart';
import 'package:restaurant_project/views/booking/booking_page.dart';
import 'package:restaurant_project/views/admin/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsianFood',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        '/signUp': (context) => SignUpPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/aboutUs': (context) => AboutUsPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/menu': (context) => MenuPage(),
        '/dishDetail': (BuildContext context) => DishDetailPage(dishId: ModalRoute.of(context)!.settings.arguments as String), // Ensure arguments are passed correctly
        '/booking': (context) => BookingPage(orders: {}), // Placeholder for orders
        '/adminDashboard': (context) => AdminDashboard(),
      },
    );
  }
}
