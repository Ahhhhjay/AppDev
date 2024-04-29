import 'package:flutter/material.dart';

class ChefCard extends StatelessWidget {
  final String chefName;
  final String description;

  ChefCard({
    required this.chefName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          // Placeholder: You might want to add an actual image or keep the icon
          child: Icon(Icons.person),
        ),
        title: Text(chefName),
        subtitle: Text(description),
      ),
    );
  }
}
