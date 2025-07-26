import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reco_genie/app_router.dart';
import 'package:reco_genie/features/auth_controller.dart';
import 'package:reco_genie/features/food_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  
  final authController = Get.put(AuthController());
  Get.put(FoodController());
  
  // Wait for Firebase Auth to initialize and check user state
  await Future.delayed(Duration(milliseconds: 500));
  
  // Check if user is actually logged in
  final currentUser = authController.user.value;
  final initialRoute = currentUser != null ? '/home' : '/login';
  
  runApp(Recogenie(initialRoute: initialRoute));
}

class Recogenie extends StatelessWidget {
  final String initialRoute;
  const Recogenie({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppRouter.routes,
    );
  }
}