import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/services/food_service.dart';
import '../models/food_category_model.dart';
import '../models/food_variety_model.dart';

class FoodController extends GetxController {
  final FoodService _foodService = FoodService();

  // Observable variables for state management
  var isLoading = false.obs;
  var selectedCategory = 'Pasta'.obs; // Set Pasta as default
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Automatically select Pasta category when controller initializes
    selectedCategory.value = 'Pasta';
  }

  // Streams for real-time data
  Stream<QuerySnapshot> get foodCategories => _foodService.getFoodCategories();
  
  Stream<QuerySnapshot> getFoodVarieties(String categoryId) {
    return _foodService.getFoodVarieties(categoryId);
  }

  // Set selected category
  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;
  }

  // Get category model from document
  FoodCategoryModel getCategoryModel(DocumentSnapshot doc) {
    return FoodCategoryModel.fromFirestore(doc.id);
  }

  // Get variety model from document
  FoodVarietyModel getVarietyModel(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return FoodVarietyModel.fromFirestore(data, doc.id);
  }

  // Legacy method for backward compatibility
  String getCategoryName(DocumentSnapshot doc) {
    return getCategoryModel(doc).name;
  }

  // Legacy method for backward compatibility
  Map<String, dynamic> getVarietyData(DocumentSnapshot doc) {
    final model = getVarietyModel(doc);
    return {
      'id': model.id,
      'name': model.name,
      'price': model.price,
      'image': model.imageUrl,
    };
  }

  // Handle errors
  void handleError(dynamic error) {
    errorMessage.value = 'Error loading food data: ${error.toString()}';
  }
} 