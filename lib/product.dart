class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.parse(json['price']),
      stockQuantity: json['stock_quantity'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}