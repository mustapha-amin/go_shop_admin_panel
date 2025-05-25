import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_shop_admin_panel/model/product.dart';

class ProductsRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ProductsRepository(this._firebaseFirestore, this._firebaseStorage);

  Future<void> uploadProduct(Product product, List<Uint8List> images) async {
    try {
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        final ref = _firebaseStorage
            .ref()
            .child('products')
            .child(product.id)
            .child('image_$i.jpg');
        await ref.putData(images[i]);
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }

      final productWithImages = product.copyWith(imageUrls: imageUrls);

      await _firebaseFirestore
          .collection('products')
          .doc(product.id)
          .set(productWithImages.toMap());
    } on FirebaseException catch (e) {
      log(e.toString(), stackTrace: StackTrace.current);
      throw "An error occured while uploading product";
    } on SocketException {
      throw "A network error occured. Please check your internet and try again";
    } catch (e) {
      throw "An unknown error occured";
    }
  }

  Future<List<Product>?> fetchProducts() async {
    final querySnap = await _firebaseFirestore.collection('products').get();
    return querySnap.docs.map((doc) => Product.fromMap(doc.data())).toList();
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // Delete product images from storage
      final storageRef = _firebaseStorage
          .ref()
          .child('products')
          .child(productId);
      final result = await storageRef.listAll();
      for (var item in result.items) {
        await item.delete();
      }

      // Delete product document
      await _firebaseFirestore.collection('products').doc(productId).delete();
    } on FirebaseException catch (e) {
      log(e.toString(), stackTrace: StackTrace.current);
      throw "An error occurred while deleting product";
    } on SocketException {
      throw "A network error occurred. Please check your internet and try again";
    } catch (e) {
      throw "An unknown error occurred";
    }
  }

  Future<void> updateProduct(
    Product product, {
    List<Uint8List>? newImages,
  }) async {
    try {
      List<String> imageUrls = product.imageUrls ?? [];

      if (newImages != null && newImages.isNotEmpty) {
        // Delete old images
        final storageRef = _firebaseStorage
            .ref()
            .child('products')
            .child(product.id);
        final result = await storageRef.listAll();
        for (var item in result.items) {
          await item.delete();
        }

        // Upload new images
        imageUrls = [];
        for (int i = 0; i < newImages.length; i++) {
          final ref = _firebaseStorage
              .ref()
              .child('products')
              .child(product.id)
              .child('image_$i.jpg');
          await ref.putData(newImages[i]);
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        }
      }

      final updatedProduct = product.copyWith(imageUrls: imageUrls);
      await _firebaseFirestore
          .collection('products')
          .doc(product.id)
          .update(updatedProduct.toMap());
    } on FirebaseException catch (e) {
      log(e.toString(), stackTrace: StackTrace.current);
      throw "An error occurred while updating product";
    } on SocketException {
      throw "A network error occurred. Please check your internet and try again";
    } catch (e) {
      throw "An unknown error occurred";
    }
  }
}
