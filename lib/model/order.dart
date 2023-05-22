import 'package:uuid/uuid.dart';

class Order {
  String? name;
  final String orderId =  const Uuid().v4();
  String? status;

  Order({this.name, this.status});
}
