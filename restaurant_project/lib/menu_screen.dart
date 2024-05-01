import 'package:flutter/material.dart';
import 'package:restaurant_project/dish.dart'; // Make sure this is correctly imported
import 'package:restaurant_project/menu_details_page.dart'; // Make sure this is correctly imported
import 'package:restaurant_project/book_and_order_page.dart'; // Assuming you have a page for booking a table

class MenuScreen extends StatelessWidget {
  final List<Dish> dishes = [
    Dish(
        name: 'Thai Rice Noodles',
        description: 'Stir-fried noodles with a blend of Thai spices, eggs, and vegetables.',
        price: 10.99,
        imageUrl: 'assets/noodles.jpg',
        allergens: ['Eggs', 'Nuts']
    ),
    Dish(
        name: 'Vegetable Curry',
        description: 'A rich curry made with seasonal vegetables and coconut milk.',
        price: 8.99,
        imageUrl: 'assets/curry.jpg',
        allergens: ['None']
    ),
    Dish(
        name: 'Chicken Teriyaki',
        description: 'Grilled chicken glazed in a homemade teriyaki sauce.',
        price: 12.99,
        imageUrl: 'assets/chicken.jpg',
        allergens: ['Soy', 'Wheat']
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          var dish = dishes[index];
          return Card(
            child: ListTile(
              leading: Image.asset(dish.imageUrl, width: 100, fit: BoxFit.cover),
              title: Text(dish.name),
              subtitle: Text('\$${dish.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetailsPage(dish: dish),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookTablePage(), // This page needs to be implemented
            ),
          );
        },
        label: Text('Book a Table'),
        icon: Icon(Icons.calendar_today),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Places the button at the bottom center
    );
  }
}
