import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_project/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://tasty.p.rapidapi.com';
  static const String apiKey = '5ccd1f20b4mshad7f2d3f69b31b0p15aeeejsn14bf310ad119';

  Future<List<Recipe>> fetchRecipes(String tag) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipes/list?from=0&size=10&tags=$tag'),
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': 'tasty.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      RecipeResponse recipeResponse = RecipeResponse.fromJson(data);
      return recipeResponse.results;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
