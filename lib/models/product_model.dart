class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String storeName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.storeName,
  });

  // لتحويل البيانات القادمة من JSON (مثل Supabase أو Firebase)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
      rating: (json['rating'] ?? 0).toDouble(),
      storeName: json['store_name'] ?? 'متجر غير معروف',
    );
  }
}
