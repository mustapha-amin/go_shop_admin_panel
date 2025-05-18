// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String description;
  final int quantity;
  final String category;
  final double basePrice;
  final double discountPercentage;
  final List<String>? imageUrls;
  final String brand;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.basePrice,
    required this.discountPercentage,
    this.imageUrls,
    required this.brand,
  });

  double get finalPrice {
    return basePrice - (basePrice * (discountPercentage / 100));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'category': category,
      'basePrice': basePrice,
      'discountPercentage': discountPercentage,
      'imageUrls': imageUrls,
      'brand' : brand,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      category: map['category'],
      basePrice: map['basePrice'],
      discountPercentage: map['discountPercentage'],
      imageUrls: List<String>.from(map['imageUrls']),
      brand: map['brand'],
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? quantity,
    String? category,
    double? basePrice,
    double? discountPercentage,
    List<String>? imageUrls,
    String? brand,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      basePrice: basePrice ?? this.basePrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      imageUrls: imageUrls ?? this.imageUrls,
      brand: brand ?? this.brand,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, quantity: $quantity, category: $category, basePrice: $basePrice, discountPercentage: $discountPercentage, imageUrls: $imageUrls, brand: $brand)';
  }
}
