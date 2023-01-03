import 'models/product.dart';

class GlobalProducts {
  static String basePath = 'assets/images/offers';
  static List<Product> products = [
    Product(
      name: "Nike air",
      imgPath: '$basePath/shoe.png',
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$basePath/shirt.png',
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$basePath/laptop.png',
      price: 90000,
    ),
    Product(
      name: "Nike air",
      imgPath: '$basePath/shoe.png',
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$basePath/shirt.png',
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$basePath/laptop.png',
      price: 90000,
    ),
  ];
}