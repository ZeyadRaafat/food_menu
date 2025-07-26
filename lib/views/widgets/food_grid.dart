import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_genie/features/food_controller.dart';
import 'package:reco_genie/views/widgets/food_card.dart';

class FoodGrid extends StatelessWidget {
  final FoodController foodController;

  const FoodGrid({
    Key? key,
    required this.foodController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (foodController.selectedCategory.value.isEmpty) {
          return Center(
            child: Text(
              'Select a category to see food items',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }
        
        return StreamBuilder<QuerySnapshot>(
          stream: foodController.getFoodVarieties(foodController.selectedCategory.value),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            
            final varieties = snapshot.data?.docs ?? [];
            
            if (varieties.isEmpty) {
              return Center(
                child: Text(
                  'No food items found in this category',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              );
            }
            
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: varieties.length,
              itemBuilder: (context, index) {
                final variety = varieties[index];
                final varietyData = foodController.getVarietyData(variety);
                
                return FoodCard(
                  name: varietyData['name'],
                  price: varietyData['price'],
                  imageUrl: varietyData['image'],
                );
              },
            );
          },
        );
      }),
    );
  }
}
