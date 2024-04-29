import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_project/models/dish_model.dart'; // Ensure you have this model

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final CollectionReference _dishesRef = FirebaseFirestore.instance.collection('dishes');
  Map<String, int> _orders = {};  // Keeps track of orders and quantities

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to a new page to review orders and proceed to booking
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(orders: _orders)));
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _dishesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error fetching data');
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              DishModel dish = DishModel.fromMap(document.data() as Map<String, dynamic>, document.id);
              return ListTile(
                title: Text(dish.name),
                subtitle: Text(dish.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateOrder(dish.id, false),
                    ),
                    Text('${_orders[dish.id] ?? 0}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateOrder(dish.id, true),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _updateOrder(String dishId, bool increment) {
    setState(() {
      if (increment) {
        if (_orders.containsKey(dishId)) {
          _orders[dishId] = _orders[dishId]! + 1;
        } else {
          _orders[dishId] = 1;
        }
      } else {
        if (_orders.containsKey(dishId) && _orders[dishId]! > 0) {
          _orders[dishId] = _orders[dishId]! - 1;
        }
      }
    });
  }
}
