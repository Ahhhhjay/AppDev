import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              // Replace with your asset image or network image as needed
              child: Icon(Icons.restaurant_menu, size: 100), // Placeholder for a large image
            ),
            SizedBox(height: 24),
            Center(
              // Replace with your asset image or network image as needed
              child: Icon(Icons.fastfood, size: 48), // Placeholder for a smaller image
            ),
            SizedBox(height: 24),
            Text(
              'AsianFood',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Enjoy the various different Asian cuisine we offer',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              'Your Chefs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Example of chef card, repeat this for each chef
            ChefCard(
              chefName: 'Steve Steve',
              description:
              'Chef Steve Steve, acclaimed for innovative dishes and Michelin stars, has reshaped global culinary arts.',
            ),
            // Add more ChefCard widgets for each additional chef
          ],
        ),
      ),
    );
  }
}
class ChefCard extends StatelessWidget {
  final String chefName;
  final String description;

  ChefCard({
    Key? key,
    required this.chefName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          // Replace with chef's image, using an asset or network image
          child: Icon(Icons.person), // Placeholder for chef's image
        ),
        title: Text(chefName),
        subtitle: Text(description),
      ),
    );
  }
}

