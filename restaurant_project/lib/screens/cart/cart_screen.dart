import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: provider.cartItems.length,
            itemBuilder: (context, index) {
              final item = provider.cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Price: \$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      Text(
                        'Rating: ${item.rating} (${item.ratingCount} reviews)',
                        style: TextStyle(fontSize: 14, color: Colors.orange),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {
                      provider.removeFromCart(item);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout successful!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(initialIndex: 0)),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.orange,
          ),
          child: Text(
            'Checkout',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
