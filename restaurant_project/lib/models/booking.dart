import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final DateTime date;
  final int guests;
  final List<dynamic> orderedDishes; // List of dishes and their quantities

  BookingModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.guests,
    required this.orderedDishes,
  });

  factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BookingModel(
      id: documentId,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      guests: data['guests'] ?? 1,
      orderedDishes: data['orderedDishes'] ?? [],
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
