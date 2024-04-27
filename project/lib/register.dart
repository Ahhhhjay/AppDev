import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj/SignIn.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Removes the shadow under the app bar.
      ),
      body: Container(
        padding: EdgeInsets.all(16), // Padding around the whole container.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Email', style: TextStyle(fontSize: 16)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16),
            Text('Password', style: TextStyle(fontSize: 16)),
            TextFormField(
              obscureText: true, // Hides password text
              decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity, // Makes the button stretch to fit the width.
              child: ElevatedButton(
                onPressed: () {
                  // Handle register button press
                },
                style: ElevatedButton.styleFrom(

                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text("I already have an account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
