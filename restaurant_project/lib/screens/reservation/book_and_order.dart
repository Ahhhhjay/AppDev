import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:restaurant_project/screens/reservation/reservationdetailspage.dart';
import '../../models/dish.dart';

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
        title: Text('Book a Table', style: TextStyle(color: Colors.orange)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextFormField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildDatePickerField(
                controller: _dateController,
                labelText: 'Select a date',
                icon: Icons.calendar_today,
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
                      _dateController.text =
                          "${picked.toLocal()}".split(' ')[0];
                    });
                },
              ),
              SizedBox(height: 16),
              _buildDatePickerField(
                controller: _timeController,
                labelText: 'Select a time',
                icon: Icons.access_time,
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
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _guestsController,
                labelText: 'Number of Guests',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of guests';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _navigateToDetailsPage(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Book Now',
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
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: Icon(icon),
      ),
      readOnly: true,
      onTap: onTap,
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
