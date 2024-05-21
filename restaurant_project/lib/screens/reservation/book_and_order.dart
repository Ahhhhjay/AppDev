import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'reservationdetailspage.dart'; // Import ReservationDetailsPage

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
                    _navigateToDetailsPage(context);
                  }
                },
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final selectedDishes = cartProvider.cartItems;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationDetailsPage(
          address: 'Restaurant Address', // Replace with actual address
          numberOfPeople: int.parse(_guestsController.text),
          dateTime: DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          ),
          selectedDishes: selectedDishes,
        ),
      ),
    );
  }
}
