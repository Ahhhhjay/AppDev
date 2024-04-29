// lib/models/dish_model.dart

class DishModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  DishModel({required this.id, required this.name, required this.description, required this.price, required this.imageUrl});

  factory DishModel.fromMap(Map<String, dynamic> data, String documentId) {
    return DishModel(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
