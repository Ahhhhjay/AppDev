import 'package:flutter/material.dart';
import 'package:restaurant_project/controllers/booking_controller.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final Map<String, int> orders;

  BookingPage({required this.orders});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              // Additional fields here
              // ...
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

    // Assuming you have a BookingController that can handle the booking
    await BookingController().bookTable(
      _nameController.text,
      _phoneNumberController.text,
      _selectedDate,
      _guests,
      widget.orders,  // Pass the ordered dishes and their quantities
    );

    Navigator.pop(context);
  }
}
