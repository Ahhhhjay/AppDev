import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/models/category.dart';
import 'package:restaurant_project/providers/recipe_provider.dart';
import 'package:restaurant_project/screens/menu/menu_details.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RecipeProvider>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.categories.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final categories = provider.categories;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ExpansionTile(
                title: Text(category.name),
                leading: Image.asset(category.imageUrl, width: 50, height: 50),
                children: category.foods.map((dish) => ListTile(
                  title: Text(dish.name),
                  subtitle: Text('\$${dish.price.toStringAsFixed(2)}'),
                  leading: Image.asset(dish.imageUrl, width: 50, height: 50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuDetailsPage(dish: dish),
                      ),
                    );
                  },
                )).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
