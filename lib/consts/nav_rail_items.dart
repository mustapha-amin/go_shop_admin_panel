import 'package:flutter/material.dart';

List<NavigationRailDestination> navRailItems = const [
  NavigationRailDestination(
    icon: Icon(Icons.home_outlined),
    label: Text("Home"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.account_circle_outlined),
    label: Text("Customers"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.store_outlined),
    label: Text("View products"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.shopping_bag_rounded),
    label: Text("Orders"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.category_outlined),
    label: Text("Add category"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.star),
    label: Text("Feature a product"),
    indicatorColor: Colors.black,
  ),
  NavigationRailDestination(
    icon: Icon(Icons.add),
    label: Text("Add products"),
    indicatorColor: Colors.black,
  ),
];
