class FoodCategoryModel {
  final String id;
  final String name;

  FoodCategoryModel({
    required this.id,
    required this.name,
  });

  factory FoodCategoryModel.fromFirestore(String id) {
    return FoodCategoryModel(
      id: id,
      name: id, // Using document ID as category name
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
} 