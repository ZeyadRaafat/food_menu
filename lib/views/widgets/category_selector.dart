import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_genie/constants.dart';
import 'package:reco_genie/features/food_controller.dart';

class CategorySelector extends StatelessWidget {
  final FoodController foodController;

  const CategorySelector({
    Key? key,
    required this.foodController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: StreamBuilder<QuerySnapshot>(
        stream: foodController.foodCategories,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          final categories = snapshot.data?.docs ?? [];
          
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryName = foodController.getCategoryName(category);
              
              return Obx(() => GestureDetector(
                onTap: () => foodController.selectCategory(category.id),
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: foodController.selectedCategory.value == category.id
                        ? appBarColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      categoryName,
                      style: TextStyle(
                        color: foodController.selectedCategory.value == category.id
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ));
            },
          );
        },
      ),
    );
  }
} 