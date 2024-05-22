import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/models/category.dart';

class ApiService {
  static const String mockyUrl =
      'https://run.mocky.io/v3/504f270a-6865-4b97-b960-f66a55d08723';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(mockyUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Category> categories =
          data.map((item) => Category.fromJson(item)).toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
