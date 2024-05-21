class Dish {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> allergens;
  final double rating;
  final int ratingCount;
  final Map<String, dynamic> nutrition;

  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.allergens,
    required this.rating,
    required this.ratingCount,
    required this.nutrition,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['food_name'],
      description: json['food_description'],
      price: json['food_price'].toDouble(),
      imageUrl: json['food_image'],
      allergens: List<String>.from(json['allergens']),
      rating: json['food_rating']['rate'].toDouble(),
      ratingCount: json['food_rating']['count'],
      nutrition: json['nutrition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_name': name,
      'food_description': description,
      'food_price': price,
      'food_image': imageUrl,
      'allergens': allergens,
      'food_rating': {
        'rate': rating,
        'count': ratingCount,
      },
      'nutrition': nutrition,
    };
  }
}
