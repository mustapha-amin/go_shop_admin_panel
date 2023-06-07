import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/model/customer.dart';

import '../model/product.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const productCollection = 'category';

  static Future<void> addCategory(Category category) async {
    await firestore
        .collection('categories')
        .doc(category.name)
        .set(category.tojson(
          category.name,
          category.imgPath,
        ));
  }

  static Future<void> addProduct(Product? product) async {
    await firestore
        .collection('categories')
        .doc(product!.category)
        .collection('products')
        .add(product.toJson(
          product.name,
          product.imgPath,
          product.price,
          product.category,
        ));
  }

  static Stream<List<Product>>? getproducts(String? categoryId) {
    return firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  static Stream<List<Category>>? getCategories() {
    return firestore.collection('categories').snapshots().map(
          (snap) => snap.docs.map((e) => Category.fromJson(e.data())).toList(),
        );
  }

  static Stream<List<Customer>> getCustomers() {
    return firestore.collection('customers').snapshots().map(
        (snap) => snap.docs.map((e) => Customer.fromJson(e.data())).toList());
  }
}
