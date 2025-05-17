import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/providers.dart';
import 'package:go_shop_admin_panel/features/products/repository/products_repository.dart';
import 'package:go_shop_admin_panel/model/product.dart';

class ProductsNotifier extends AsyncNotifier<List<Product>?> {
  final ProductsRepository _productsRepository;

  ProductsNotifier(this._productsRepository);

  @override
  Future<List<Product>?> build() {
    return ref.read(productRepoProvider).fetchProducts();
  }

  void addProducts(Product product, List<Uint8List> images) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(productRepoProvider).uploadProduct(product, images);
      return ref.read(productRepoProvider).fetchProducts();
    });
  }
}
