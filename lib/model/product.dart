class Product {
  final String id;
  final String name;
  final String description;
  final int quantity;
  final String category;
  final double basePrice;
  final double discountPercentage;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.basePrice,
    required this.discountPercentage,
    required this.imageUrls,
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
    );
  }
}
