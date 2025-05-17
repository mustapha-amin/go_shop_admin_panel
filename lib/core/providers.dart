import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/features/products/repository/products_repository.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final storageProvider = Provider((ref) => FirebaseStorage.instance);
final productRepoProvider = Provider((ref) {
  return ProductsRepository(
    ref.read(firestoreProvider),
    ref.read(storageProvider),
  );
});

final appIsLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

void toggleLoader(WidgetRef ref, bool value) {
  ref.read(appIsLoadingProvider.notifier).state = value;
}
