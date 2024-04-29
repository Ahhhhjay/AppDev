import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/auth/sign_in_page.dart';
import 'views/auth/sign_up_page.dart';
import 'views/auth/forgot_password_page.dart';
import 'views/main/home_page.dart';
import 'views/main/about_us_page.dart';
import 'views/main/profile_page.dart';
import 'views/main/settings_page.dart';
import 'views/menu/menu_page.dart';
import 'views/menu/dish_detail_page.dart';
import 'views/booking/booking_page.dart';
import 'views/admin/admin_dashboard.dart';

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
        '/dishDetail': (context) => DishDetailPage(),
        '/booking': (context) => BookingPage(),
        '/adminDashboard': (context) => AdminDashboard(), // Ensure the AdminDashboard view is created
      },
    );
  }
}
