import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_project/screens/home/home_page.dart'; // Ensure you have the HomePage import

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Create a map to hold the updates
        Map<String, dynamic> updates = {};

        // Only add non-empty fields to the updates map
        if (_name.isNotEmpty) {
          updates['name'] = _name;
        }
        if (_email.isNotEmpty) {
          updates['email'] = _email;
        }

        // Update the user's information in Firestore
        if (updates.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(updates, SetOptions(merge: true));
        }

        // Update the user's email and password in Firebase Auth
        if (_email.isNotEmpty) {
          try {
            await user.updateEmail(_email);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update email: $e')),
            );
            return;
          }
        }
        if (_password.isNotEmpty) {
          try {
            await user.updatePassword(_password);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update password: $e')),
            );
            return;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );

        // Navigate to HomePage with ProfilePage selected after successful update
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(initialIndex: 3)),
        );
      }
    }
  }
}