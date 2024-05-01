import 'package:flutter/material.dart';
import 'package:restaurant_project/dish.dart';  // Ensure you have the correct import for the Dish model

class MenuDetailsPage extends StatelessWidget {
  final Dish dish;

  MenuDetailsPage({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(dish.imageUrl, fit: BoxFit.cover, height: 250, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: \$${dish.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  Text(
                    dish.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  if (dish.allergens.isNotEmpty)
                    Text(
                      'Allergens: ${dish.allergens.join(', ')}',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement the Add to Cart functionality
                  // For now, just pop back
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
