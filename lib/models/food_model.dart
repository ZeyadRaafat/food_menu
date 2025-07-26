class FoodModel {
  final String name;
  final double price;
  final String image;

  FoodModel({required this.name, required this.price, required this.image});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
}
