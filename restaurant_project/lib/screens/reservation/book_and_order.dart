import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Add this package for date and time formatting
import 'package:restaurant_project/screens/reservation/reservationdetailspage.dart'; // Make sure this is correctly imported

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
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Select a date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Select a time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
              ),
              TextFormField(
                controller: _guestsController,
                decoration: InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationDetailsPage(
                        address: "123 Disney Way, Willingmington, WV 24921",
                        numberOfPeople: int.tryParse(_guestsController.text) ?? 1,
                        dateTime: DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ),
                        // Assuming selectedDishes is required
                        selectedDishes: [], // You would populate this from your menu selection logic
                      ),
                    ),
                  );
                  // if (_formKey.currentState.validate()) {
                  //   // Assuming the ReservationDetailsPage accepts parameters
                  //
                  // }
                },
                style: ElevatedButton.styleFrom(),
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
