import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_project/screens/account/about_us.dart';
import 'package:restaurant_project/screens/account/edit_profile.dart';
import 'package:restaurant_project/screens/cart/cart_screen.dart';
import 'package:restaurant_project/screens/auth/sign_in.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _userName = userDoc['name'] ?? 'User';
      });
    } else {
      setState(() {
        _userName = 'User';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(_userName, style: TextStyle(color: Colors.orange)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.orange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Thank you for supporting us! As a local business, we thank you for supporting us and hope you enjoy.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildListTile(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.exit_to_app,
              title: 'Log out',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
      ),
    );
  }
}
