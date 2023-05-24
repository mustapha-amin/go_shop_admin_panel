import 'package:uuid/uuid.dart';

class Order {
  String? name;
  final String orderId = const Uuid().v4().substring(0, 8);
  bool? status;

  Order({this.name, this.status});
}
