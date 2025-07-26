import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_genie/models/food_model.dart';


Future<List<FoodModel>> fetchFoods() async {
  final snapshot = await FirebaseFirestore.instance.collection('food').get();
  return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();
}
