import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/models/dish.dart';
import 'package:restaurant_project/providers/cart_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Dish dish;

  RecipeDetailScreen({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(dish.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16.0),
            Text(
              dish.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${dish.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
            SizedBox(height: 8.0),
            Text(
              'Rating: ${dish.rating} (${dish.ratingCount} reviews)',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              dish.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Allergens: ${dish.allergens.join(', ')}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nutrition: Calories: ${dish.nutrition['calories']}, Fat: ${dish.nutrition['fat']}, Carbs: ${dish.nutrition['carbohydrates']}, Protein: ${dish.nutrition['protein']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(dish);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${dish.name} added to cart')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
