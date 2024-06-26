import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String address;
  final int numberOfPeople;
  final DateTime dateTime;
  final List<Map<String, dynamic>> selectedDishes;

  ReservationDetailsPage({
    required this.address,
    required this.numberOfPeople,
    required this.dateTime,
    required this.selectedDishes,
  });

  Future<void> _bookTable(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to be logged in to make a booking')),
      );
      return;
    }

    List<Map<String, dynamic>> dishesWithTotalPrice = selectedDishes.map((item) {
      return {
        'name': item['dish'].name,
        'price': item['dish'].price,
        'quantity': item['quantity'],
        'totalPrice': item['quantity'] * item['dish'].price,
      };
    }).toList();

    double totalPrice = dishesWithTotalPrice.fold(0.0, (sum, item) => sum + item['totalPrice']);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .add({
      'address': address,
      'numberOfPeople': numberOfPeople,
      'date': dateTime,
      'dishes': dishesWithTotalPrice,
      'totalPrice': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Provider.of<CartProvider>(context, listen: false).clearCart();

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
    double totalPrice = selectedDishes.fold(0.0, (sum, item) => sum + (item['quantity'] * item['dish'].price));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservation Details',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Reservation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 20),
              _buildDetailRow('Address:', address),
              SizedBox(height: 10),
              _buildDetailRow('Number of People:', '$numberOfPeople'),
              SizedBox(height: 10),
              _buildDetailRow(
                'Date:',
                '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
              ),
              SizedBox(height: 10),
              Text(
                'Selected Dishes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 10),
              ...selectedDishes.map((item) => Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                    item['dish'].name,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'Quantity: ${item['quantity']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    '\$${(item['quantity'] * item['dish'].price).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
              SizedBox(height: 10),
              _buildDetailRow(
                'Total Price:',
                '\$${totalPrice.toStringAsFixed(2)}',
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _bookTable(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
