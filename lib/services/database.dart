import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';

import '../model/product.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const productCollection = 'category';

  Future<void> addCategory(Category category) async {
    await firestore
        .collection('categories')
        .doc(category.name)
        .set(category.tojson(
          category.name,
          category.imgPath,
        ));
  }

  Future<void> addProduct(Product? product) async {
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

  Stream<List<Product>> getproducts(String? categoryId) {
    return firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  Stream<List<Category>> getCategories() {
    return firestore.collection('categories').snapshots().map(
          (snap) => snap.docs.map((e) => Category.fromJson(e.data())).toList(),
        );
  }
}
