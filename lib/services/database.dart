import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/product.dart';
import '/utils/snackbar.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static const productCollection = 'category';

  static Future<void> addCategory(
      BuildContext context, Category category) async {
    try {
      final path =
          'categories/${category.name}/${category.name}.${category.imgPath!.split('.').last}';
      final file = File(category.imgPath!);
      final ref = firebaseStorage.ref().child(path);
      await ref.putFile(file);
      final imgUrl = await ref.getDownloadURL();
      await firestore
          .collection('categories')
          .doc(category.name)
          .set(category.tojson(
            category.name,
            imgUrl,
          ));
      // ignore: use_build_context_synchronously
      showSnackbar(context, "Product category added");
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  static Future<void> addProduct(BuildContext context, Product? product) async {
    try {
      final path =
          'products/${product!.category}/${product.name}.${product.imgPath!.split('.').last}';
      final file = File(product.imgPath!);
      final ref = firebaseStorage.ref().child(path);
      await ref.putFile(file);
      final imgUrl = await ref.getDownloadURL();
      await firestore
          .collection('categories')
          .doc(product.category)
          .collection('products')
          .add(product.toJson(
            product.name,
            imgUrl,
            product.price,
            product.category,
          ));
      // ignore: use_build_context_synchronously
      showSnackbar(context, "Product added");
    } catch (e) {
      log(e.toString());
      Navigator.pop(context);
    }
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
