// lib/controllers/menu_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class MenuController {
  final CollectionReference dishesCollection = FirebaseFirestore.instance.collection('dishes');

  Future<void> addDish(String name, String description, double price, String imageUrl) async {
    await dishesCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  Stream<QuerySnapshot> getDishesStream() {
    return dishesCollection.snapshots();
  }

// Any other dish-related logic can be added here
}
