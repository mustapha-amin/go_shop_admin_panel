import 'model/category.dart';
import 'model/product.dart';

class GlobalProducts {
  static String productsBasePath = 'assets/images/offers';
  static String categoriesBasePath = 'assets/images/categories';
  static List<Product> products = [
    Product(
      name: "Nike air",
      imgPath: '$productsBasePath/shoe.png',
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$productsBasePath/shirt.png',
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$productsBasePath/laptop.png',
      price: 90000,
    ),
    Product(
      name: "Nike air",
      imgPath: '$productsBasePath/shoe.png',
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$productsBasePath/shirt.png',
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$productsBasePath/laptop.png',
      price: 90000,
    ),
  ];

  static List<Category> categories = [
    Category(name: "Shoes", imgPath: '$categoriesBasePath/shoes.png'),
    Category(name: "Clothes", imgPath: '$categoriesBasePath/clothes.png'),
    Category(name: "Laptops", imgPath: '$categoriesBasePath/computers.png'),
    Category(name: "Assesories", imgPath: '$categoriesBasePath/assesories.png'),
    Category(
        name: "Smartphones", imgPath: '$categoriesBasePath/smartphones.png'),
    Category(name: "Watches", imgPath: '$categoriesBasePath/watches.png'),
    Category(name: "Gaming", imgPath: '$categoriesBasePath/gaming.png'),
    Category(
        name: "Electronics", imgPath: '$categoriesBasePath/electronics.png'),
  ];
}
