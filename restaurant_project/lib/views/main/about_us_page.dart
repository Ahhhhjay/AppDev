// lib/views/main/about_us_page.dart
import 'package:flutter/material.dart';
import 'package:restaurant_project/widgets/chef_card.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Icon(Icons.restaurant_menu, size: 100)),
            SizedBox(height: 24),
            Center(child: Icon(Icons.fastfood, size: 48)),
            SizedBox(height: 24),
            Text('AsianFood', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Enjoy the various different Asian cuisine we offer...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            Text('Our Chefs', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ChefCard(
              chefName: 'Chef Steve',
              description: 'Acclaimed for innovative dishes...',
            ),
          ],
        ),
      ),
    );
  }
}
