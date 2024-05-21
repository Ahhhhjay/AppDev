import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_project/models/recipe.dart';

class CartProvider with ChangeNotifier {
  List<Recipe> _cartItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId = 'exampleUserId'; // Replace with actual user ID management logic

  List<Recipe> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').doc(_userId).collection('cart').get();
      _cartItems = snapshot.docs.map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  Future<void> addToCart(Recipe recipe) async {
    try {
      _cartItems.add(recipe);
      await _firestore.collection('users').doc(_userId).collection('cart').add(recipe.toJson());
      notifyListeners();
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(Recipe recipe) async {
    try {
      _cartItems.remove(recipe);
      QuerySnapshot snapshot = await _firestore.collection('users').doc(_userId).collection('cart')
          .where('name', isEqualTo: recipe.name)
          .get();
      for (var doc in snapshot.docs) {
        await _firestore.collection('users').doc(_userId).collection('cart').doc(doc.id).delete();
      }
      notifyListeners();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      _cartItems.clear();
      QuerySnapshot snapshot = await _firestore.collection('users').doc(_userId).collection('cart').get();
      for (var doc in snapshot.docs) {
        await _firestore.collection('users').doc(_userId).collection('cart').doc(doc.id).delete();
      }
      notifyListeners();
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}
