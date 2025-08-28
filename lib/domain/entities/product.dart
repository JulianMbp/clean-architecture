class Product {
  final String id;
  final String sku;
  final String name;
  final double price;
  final double cost;
  final String description;
  final int stockQuantity;
  final int minStock;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.cost,
    required this.description,
    required this.stockQuantity,
    required this.minStock,
  });

  Product copyWith({
    String? id,
    String? sku,
    String? name,
    double? price,
    double? cost,
    String? description,
    int? stockQuantity,
    int? minStock,
  }) {
    return Product(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minStock: minStock ?? this.minStock,
    );
  }
}
