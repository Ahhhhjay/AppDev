import 'dish.dart';

class Category {
  final int id;
  final String name;
  final String imageUrl;
  final List<Dish> foods;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.foods,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var foodsList = json['foods'] as List;
    List<Dish> foods = foodsList.map((i) => Dish.fromJson(i)).toList();

    return Category(
      id: json['id'],
      name: json['category_name'],
      imageUrl: json['category_image'],
      foods: foods,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': name,
      'category_image': imageUrl,
      'foods': foods.map((food) => food.toJson()).toList(),
    };
  }
}
