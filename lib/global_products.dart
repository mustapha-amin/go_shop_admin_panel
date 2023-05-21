import 'model/category.dart';
import 'model/product.dart';

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

  List<Category> categories = [
    Category(name: "Shoes", imgPath: '$basePath/shoes.png'),
    Category(name: "Clothes", imgPath: '$basePath/clothes.png'),
    Category(name: "Laptops", imgPath: '$basePath/computers.png'),
    Category(name: "Assesories", imgPath: '$basePath/assesories.png'),
    Category(name: "Smartphones", imgPath: '$basePath/smartphones.png'),
    Category(name: "Watches", imgPath: '$basePath/watches.png'),
    Category(name: "Gaming", imgPath: '$basePath/gaming.png'),
    Category(name: "Electronics", imgPath: '$basePath/electronics.png'),
  ];
}