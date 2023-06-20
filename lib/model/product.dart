import 'package:uuid/uuid.dart';

class Product {
  String? id;
  String? name;
  String? imgPath;
  double? price;
  String? category;
  String? description;

  Product({
    String? id,
    this.name,
    this.imgPath,
    this.price,
    this.category,
    this.description,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson(
    String? id,
    String? name,
    String? imgPath,
    double? price,
    String? category,
    String? description,
  ) {
    return {
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'price': price,
      'category': category,
      'description': description,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        imgPath: json['imgPath'],
        price: json['price'],
        category: json['category'],
        description: json['descr']
      );
  }
}
