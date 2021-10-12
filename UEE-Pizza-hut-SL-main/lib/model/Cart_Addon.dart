class Cart_Addon {
  final String name;
  final double price;

  Cart_Addon({required this.name, required this.price});

  factory Cart_Addon.fromJson(Map<String, dynamic> json) {
    return Cart_Addon(name: json['name'], price: json['price']);
  }
}
