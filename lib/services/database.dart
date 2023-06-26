import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/featured_product.dart';
import '../model/product.dart';
import '/utils/snackbar.dart';
import '../model/order.dart' as k;

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static const productCollection = 'category';

  Future<void> addCategory(BuildContext context, Category category) async {
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
      Navigator.pop(context);
      showSnackbar(context, "Product category added");
    } catch (e) {
      Navigator.pop(context);
      showSnackbar(context, e.toString());
    }
  }

  Future<void> addProduct(BuildContext context, Product? product) async {
    try {
      final path =
          'products/${product!.category}/${product.name}.${product.imgPath!.split('.').last}';
      final file = File(product.imgPath!);
      final ref = firebaseStorage.ref().child(path);
      await ref.putFile(file);
      final imgUrl = await ref.getDownloadURL();
      product.imgPath = imgUrl;
      await firestore
          .collection('products')
          .doc(product.id)
          .set(product.toJson());
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showSnackbar(context, "Product added");
    } catch (e) {
      log(e.toString());
      Navigator.pop(context);
      showSnackbar(context, e.toString());
    }
  }

  static Stream<List<Product>>? getproducts(String? categoryId) {
    return firestore
        .collection('products')
        .where('category', isEqualTo: categoryId)
        .get()
        .asStream()
        .map((snap) =>
            snap.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await firestore.collection('products').doc(product.id).delete();
      final path = 'products/${product.category}/${product.name}.png}';
      final ref = firebaseStorage.ref().child(path);
      await ref.delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> featureProduct(FeaturedProduct featuredProduct) async {
    firestore.collection('featured').doc(featuredProduct.product!.id).set(
        featuredProduct.toJson(
            featuredProduct.product, featuredProduct.message));
  }

  Stream<List<FeaturedProduct>> getFeaturedProducts() {
    return firestore.collection('featured').snapshots().map((snap) =>
        snap.docs.map((e) => FeaturedProduct.fromJson(e.data())).toList());
  }

  Future<void> removeFromFeatured(String? id) async {
    await firestore.collection('featured').doc(id).delete();
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

  Stream<List<k.Order>> fetchOrders() {
    return firestore
        .collection('orders').snapshots()
        .map((snap) =>
            snap.docs.map((e) => k.Order.fromJson(e.data())).toList());
  }
}
