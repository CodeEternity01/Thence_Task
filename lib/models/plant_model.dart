class Plant {
  final int id;
  final int categoryId;
  final String imageUrl;
  final String name;
  final double rating;
  final int displaySize;
  final List<int> availableSizes;
  final String unit;
  final String price;
  final String priceUnit;
  final String description;

  Plant({
    required this.id,
    required this.categoryId,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.displaySize,
    required this.availableSizes,
    required this.unit,
    required this.price,
    required this.priceUnit,
    required this.description,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      categoryId: json['category_id'],
      imageUrl: json['image_url'],
      name: json['name'],
      rating: json['rating'].toDouble(),
      displaySize: json['display_size'],
      availableSizes: List<int>.from(json['available_size']),
      unit: json['unit'],
      price: json['price'],
      priceUnit: json['price_unit'],
      description: json['description'],
    );
  }
}
