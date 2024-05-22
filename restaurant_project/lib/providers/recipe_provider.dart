import 'package:flutter/material.dart';
import 'package:restaurant_project/providers/api_service.dart';
import 'package:restaurant_project/models/category.dart';

class RecipeProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _loading = false;

  List<Category> get categories => _categories;
  bool get loading => _loading;

  Future<void> fetchCategories() async {
    _setLoading(true);

    try {
      _categories = await ApiService().fetchCategories();
    } catch (e) {
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
