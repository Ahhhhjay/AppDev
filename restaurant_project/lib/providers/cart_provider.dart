import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_project/models/dish.dart';

class CartProvider with ChangeNotifier {
  List<Dish> _cartItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _userId;

  List<Dish> get cartItems => _cartItems;

  CartProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      await _loadCartItems();
    } else {
      print('No user logged in');
    }
  }

  Future<void> _loadCartItems() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();
      _cartItems = snapshot.docs
          .map((doc) => Dish.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  Future<void> addToCart(Dish dish) async {
    try {
      _cartItems.add(dish);
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .add(dish.toJson());
      notifyListeners();
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(Dish dish) async {
    try {
      _cartItems.remove(dish);
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .where('food_name', isEqualTo: dish.name)
          .get();
      for (var doc in snapshot.docs) {
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('cart')
            .doc(doc.id)
            .delete();
      }
      notifyListeners();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      _cartItems.clear();
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();
      for (var doc in snapshot.docs) {
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('cart')
            .doc(doc.id)
            .delete();
      }
      notifyListeners();
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}
