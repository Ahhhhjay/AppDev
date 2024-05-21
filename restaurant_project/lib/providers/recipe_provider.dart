import 'package:flutter/material.dart';
import 'package:restaurant_project/providers/api_service.dart';
import 'package:restaurant_project/models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  bool _loading = false;

  List<Recipe> get recipes => _recipes;
  bool get loading => _loading;

  Future<void> fetchRecipes(String tag) async {
    _loading = true;
    notifyListeners();

    try {
      _recipes = await ApiService().fetchRecipes(tag);
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
