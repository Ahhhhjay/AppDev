// lib/views/menu/menu_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_project/models/dish.dart'; // Ensure the correct import path
import 'package:restaurant_project/views/menu/dish_detail_page.dart';

class MenuPage extends StatelessWidget {
  final CollectionReference _dishesRef = FirebaseFirestore.instance.collection('dishes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _dishesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error fetching data'));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              DishModel dish = DishModel.fromSnapshot(document);
              return ListTile(
                leading: Image.network(dish.imageUrl, fit: BoxFit.cover, width: 100),
                title: Text(dish.name),
                subtitle: Text(dish.description),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DishDetailPage(dishId: document.id)));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
