import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

class BookTablePage extends StatefulWidget {
  @override
  _BookTablePageState createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _guestsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Select a date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                      _dateController.text = "${picked.toLocal()}".split(' ')[0];
                    });
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Select a time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null && picked != selectedTime)
                    setState(() {
                      selectedTime = picked;
                      _timeController.text = picked.format(context);
                    });
                },
              ),
              TextFormField(
                controller: _guestsController,
                decoration: InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of guests';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _bookTable(context);
                  }
                },
                style: ElevatedButton.styleFrom(

                ),
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bookTable(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to be logged in to make a booking')),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    List<Map<String, dynamic>> dishes = cartProvider.cartItems.map((item) {
      return {
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
      };
    }).toList();

    await FirebaseFirestore.instance.collection('bookings').add({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'date': selectedDate,
      'time': selectedTime.format(context),
      'guests': int.parse(_guestsController.text),
      'dishes': dishes,
      'userId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    cartProvider.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking successful!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
