import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

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
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Edit Profile', style: TextStyle(color: Colors.orange)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              _buildTextFormField(
                labelText: 'Full Name',
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                labelText: 'Email',
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                labelText: 'Password',
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    bool obscureText = false,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
      onSaved: onSaved,
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
