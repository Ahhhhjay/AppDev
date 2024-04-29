import 'package:flutter/material.dart';
import 'package:restaurant_project/views/menu/menu_page.dart';
import 'package:restaurant_project/views/booking/booking_page.dart';
import 'package:restaurant_project/views/main/about_us_page.dart';
import 'package:restaurant_project/views/main/profile_page.dart';
import 'package:restaurant_project/views/main/settings_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Menu'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book_online),
            title: Text('Book a Table'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
          ),
        ],
      ),
    );
  }
}
