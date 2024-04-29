import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  // Ensure this package is correctly imported

class BookingPage extends StatefulWidget {
  final Map<String, int> orders;

  BookingPage({required this.orders});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _guests = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Table'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone number' : null,
              ),
              ListTile(
                title: Text("Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              DropdownButtonFormField<int>(
                value: _guests,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _guests = newValue;
                    });
                  }
                },
                items: List.generate(10, (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1} guests'),
                )),
                decoration: InputDecoration(
                  labelText: 'Number of Guests',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _bookTable(),
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bookTable() async {
    if (!_formKey.currentState!.validate()) return;
    FirebaseFirestore.instance.collection('bookings').add({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'name': _nameController.text,
      'phoneNumber': _phoneNumberController.text,
      'date': _selectedDate,
      'guests': _guests,
      'orderedDishes': widget.orders,
    });
    Navigator.pop(context);
  }
}
