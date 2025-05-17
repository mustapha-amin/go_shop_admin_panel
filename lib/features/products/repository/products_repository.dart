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

      final productWithImages = Product(
        id: product.id,
        name: product.name,
        description: product.description,
        quantity: product.quantity,
        category: product.category,
        basePrice: product.basePrice,
        discountPercentage: product.discountPercentage,
        imageUrls: imageUrls,
      );

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
}
