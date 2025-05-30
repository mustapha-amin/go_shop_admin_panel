import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:go_shop_admin_panel/model/order.dart';

class OrderRepository {
  final FirebaseFirestore firestore;
  OrderRepository({required this.firestore});

  Future<List<Order>> fetchOrders() async {
    try {
      final querySnapshot = await firestore
          .collection('orders')
          .get();

      return querySnapshot.docs
          .map((doc) => Order.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }
}
