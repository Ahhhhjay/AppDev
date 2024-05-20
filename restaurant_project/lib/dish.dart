class Dish {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> allergens;

  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.allergens,
  });
}
