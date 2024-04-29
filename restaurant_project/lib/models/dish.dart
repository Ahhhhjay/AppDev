// lib/models/dish_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DishModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantity; // Useful for cart functionality

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });

  factory DishModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return DishModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      quantity: 0, // Default quantity is zero unless specified
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
