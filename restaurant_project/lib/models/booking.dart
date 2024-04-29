// lib/models/booking_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final DateTime date;
  final int guests;
  final List<dynamic> orderedDishes;

  BookingModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.guests,
    this.orderedDishes = const [],
  });

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    return BookingModel(
      id: snapshot.id,
      userId: snapshot['userId'] ?? '',
      name: snapshot['name'] ?? '',
      phoneNumber: snapshot['phoneNumber'] ?? '',
      date: (snapshot['date'] as Timestamp).toDate(),
      guests: snapshot['guests'] ?? 1,
      orderedDishes: snapshot['orderedDishes'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'date': date,
      'guests': guests,
      'orderedDishes': orderedDishes,
    };
  }
}
