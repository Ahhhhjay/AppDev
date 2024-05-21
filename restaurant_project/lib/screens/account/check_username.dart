import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'complete_profile.dart';
import 'package:restaurant_project/screens/home/home_page.dart'; // Ensure you have a HomePage import

class CheckUsernamePage extends StatefulWidget {
  @override
  _CheckUsernamePageState createState() => _CheckUsernamePageState();
}

class _CheckUsernamePageState extends State<CheckUsernamePage> {
  @override
  void initState() {
    super.initState();
    _checkUsername();
  }

  Future<void> _checkUsername() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists &&
            userDoc.data() != null &&
            userDoc.get('name') != null) {
          // If username exists, navigate to HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } catch (e) {
        print('Error checking username: $e');
        // Handle the case where 'name' field might not exist or any other error
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompleteProfilePage()),
        );
      }
    } else {
      print('No user logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}