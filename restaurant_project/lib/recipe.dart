class Recipe {
  final String name;
  final String thumbnailUrl;
  final List<String> ingredients;

  Recipe({
    required this.name,
    required this.thumbnailUrl,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredientsList = [];
    if (json['sections'] != null && json['sections'][0]['components'] != null) {
      ingredientsList = List<String>.from(json['sections'][0]['components'].map((x) => x['ingredient']['name'].toString()));
    }
    return Recipe(
      name: json['name'],
      thumbnailUrl: json['thumbnail_url'],
      ingredients: ingredientsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'thumbnail_url': thumbnailUrl,
      'ingredients': ingredients,
    };
  }
}

class RecipeResponse {
  final List<Recipe> results;

  RecipeResponse({required this.results});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Recipe> recipeList = list.map((i) => Recipe.fromJson(i)).toList();
    return RecipeResponse(results: recipeList);
  }
}
