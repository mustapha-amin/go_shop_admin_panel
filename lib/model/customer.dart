class Customer {
  String? id;
  String? name;
  String? email;

  Customer({this.id, this.name, this.email});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
