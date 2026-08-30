class Product {
  final String id;
  final String name;
  final double price;
  final String categoryId;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
    };
  }
}