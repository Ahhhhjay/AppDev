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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        elevation: 0,
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.asset(category.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    children: category.foods.map((dish) => ListTile(
                      title: Text(
                        dish.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '\$${dish.price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.green),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.asset(dish.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuDetailsPage(dish: dish),
                          ),
                        );
                      },
                    )).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
