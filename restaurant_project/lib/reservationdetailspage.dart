import 'package:flutter/material.dart';
import 'package:restaurant_project/dish.dart'; // Make sure the Dish class is correctly imported

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
              'Date: ${dateTime.year}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')} at ${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}',
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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Your reservation has been booked!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
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
