// lib/controllers/booking_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingController {
  final CollectionReference bookingCollection = FirebaseFirestore.instance.collection('bookings');

  Future<void> bookTable(String name, String phoneNumber, DateTime date, int guests) async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User must be logged in to book a table.");
    }

    await bookingCollection.add({
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'date': date,
      'guests': guests,
    });
  }
}
