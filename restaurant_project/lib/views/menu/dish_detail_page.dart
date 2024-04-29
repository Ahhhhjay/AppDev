import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DishDetailPage extends StatelessWidget {
  final String dishId;

  DishDetailPage({required this.dishId});

  @override
  Widget build(BuildContext context) {
    CollectionReference dishes = FirebaseFirestore.instance.collection('dishes');

    return Scaffold(
      appBar: AppBar(
        title: Text('Dish Details'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: dishes.doc(dishId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(data['imageUrl'], height: 250, fit: BoxFit.cover),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(data['description'], style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Placeholder for add to cart functionality
                    },
                    child: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
