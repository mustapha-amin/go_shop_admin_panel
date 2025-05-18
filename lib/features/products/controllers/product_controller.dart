import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/providers.dart';
import 'package:go_shop_admin_panel/model/product.dart';

final productNotifierProvider =
    AsyncNotifierProvider<ProductsNotifier, List<Product>?>(
      ProductsNotifier.new,
    );

class ProductsNotifier extends AsyncNotifier<List<Product>?> {
  @override
  Future<List<Product>?> build() {
    return ref.read(productRepoProvider).fetchProducts();
  }

  Future<void> addProducts(Product product, List<Uint8List> images) async {
    ref.read(appIsLoadingProvider.notifier).state = true;
    state = await AsyncValue.guard(() async {
      ref.read(productRepoProvider).uploadProduct(product, images);
      return ref.read(productRepoProvider).fetchProducts();
    });
    ref.read(appIsLoadingProvider.notifier).state = false;
  }
}
