import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDish(String name, String description, double price, String imageUrl) async {
    await _firestore.collection('dishes').add({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  Stream<QuerySnapshot> getBookings() {
    return _firestore.collection('bookings').snapshots();
  }
}