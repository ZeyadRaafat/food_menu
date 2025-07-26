import 'package:cloud_firestore/cloud_firestore.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all food categories (Pasta, meat, pizza, etc.)
  Stream<QuerySnapshot> getFoodCategories() {
    return _firestore.collection('food').snapshots();
  }

  // Fetch variety items for a specific food category
  Stream<QuerySnapshot> getFoodVarieties(String categoryId) {
    return _firestore
        .collection('food')
        .doc(categoryId)
        .collection('variety')
        .snapshots();
  }

  // Fetch a single food category document
  Future<DocumentSnapshot> getFoodCategory(String categoryId) {
    return _firestore.collection('food').doc(categoryId).get();
  }

  // Fetch a single variety item
  Future<DocumentSnapshot> getFoodVariety(String categoryId, String varietyId) {
    return _firestore
        .collection('food')
        .doc(categoryId)
        .collection('variety')
        .doc(varietyId)
        .get();
  }
} 