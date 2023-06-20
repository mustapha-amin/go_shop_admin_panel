import 'package:go_shop_admin_panel/model/product.dart';

class FeaturedProduct {
  Product? product;
  String? message;

  FeaturedProduct({this.product, this.message});

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson(Product? product, String? message) {
    return {
      'product': product!.toJson(
        product.id,
        product.name,
        product.imgPath,
        product.price,
        product.category,
        product.description,
      ),
      'message': message,
    };
  }
}
