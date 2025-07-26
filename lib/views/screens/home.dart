import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reco_genie/constants.dart';
import 'package:reco_genie/features/food_controller.dart';
import 'package:reco_genie/views/widgets/category_selector.dart';
import 'package:reco_genie/views/widgets/food_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.put(FoodController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Menu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/login');
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Section
          CategorySelector(foodController: foodController),
          
          // Food Items Section
          FoodGrid(foodController: foodController),
        ],
      ),
    );
  }
}