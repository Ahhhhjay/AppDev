import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant_project/notification_service.dart';
import 'package:restaurant_project/screens/home/home_page.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }
          return ListView.builder(
            itemCount: provider.cartItems.length,
            itemBuilder: (context, index) {
              final item = provider.cartItems[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: item.thumbnailUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(item.name),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    provider.removeFromCart(item);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            Provider.of<CartProvider>(context, listen: false).clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout successful!')),
            );
            await NotificationService().showNotification(
              0,
              'Checkout Successful',
              'Your order has been placed successfully!',
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text('Checkout'),
        ),
      ),
    );
  }
}
