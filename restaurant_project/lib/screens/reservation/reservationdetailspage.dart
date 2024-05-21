import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/models/dish.dart'; // Make sure the Dish class is correctly imported
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String address;
  final int numberOfPeople;
  final DateTime dateTime;
  final List<Dish> selectedDishes; // Include a list of selected dishes

  ReservationDetailsPage({
    required this.address,
    required this.numberOfPeople,
    required this.dateTime,
    required this.selectedDishes, // Require the list of dishes in the constructor
  });

  Future<void> _bookTable(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to be logged in to make a booking')),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    List<Map<String, dynamic>> dishes = selectedDishes.map((dish) {
      return {
        'name': dish.name,
        'price': dish.price,
      };
    }).toList();

    await FirebaseFirestore.instance.collection('bookings').add({
      'address': address,
      'numberOfPeople': numberOfPeople,
      'date': dateTime,
      'dishes': dishes,
      'userId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    cartProvider.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking successful!')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              address,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Number of People: $numberOfPeople',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Selected Dishes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...selectedDishes.map((dish) => Text(
              '${dish.name} - \$${dish.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            )).toList(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                _bookTable(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
