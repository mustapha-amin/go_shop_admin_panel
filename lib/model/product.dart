class Product {
  String? name;
  String? imgPath;
  double? price;
  String? category;

  Product({
    this.name,
    this.imgPath,
    this.price,
    this.category,
  });

  Map<String, dynamic> toJson(
    String? name,
    String? imgPath,
    double? price,
    String? category,
  ) {
    return {
      'name': name,
      'imgPath': imgPath,
      'price': price,
      'category': category,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      imgPath: json['imgPath'],
      price: json['price'],
      category: json['category'],
    );
  }
}
