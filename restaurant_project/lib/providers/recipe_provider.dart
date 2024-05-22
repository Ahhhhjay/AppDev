import 'package:flutter/material.dart';
import 'package:restaurant_project/models/category.dart';
import 'package:restaurant_project/providers/api_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _loading = false;

  List<Category> get categories => _categories;

  bool get loading => _loading;

  Future<void> fetchCategories() async {
    _loading = true;
    notifyListeners();

    try {
      _categories = await ApiService().fetchCategories();
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
