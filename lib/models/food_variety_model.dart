class FoodVarietyModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  FoodVarietyModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory FoodVarietyModel.fromFirestore(Map<String, dynamic> data, String id) {
    final priceRaw = data['price'] ?? 0.0;
    final price = (priceRaw is int) ? priceRaw.toDouble() : (priceRaw is double ? priceRaw : 0.0);
    
    return FoodVarietyModel(
      id: id,
      name: data['name'] ?? 'Unknown',
      price: price,
      imageUrl: data['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': imageUrl,
    };
  }
} 