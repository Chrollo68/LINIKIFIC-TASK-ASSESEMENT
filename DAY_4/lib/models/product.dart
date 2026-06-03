class Product {
  final String name;
  final String subtitle;
  final String category;
  final double price;
  final double rating;

  const Product({
    required this.name,
    required this.subtitle,
    required this.category,
    required this.price,
    required this.rating,
  });
}

final List<Product> sampleProducts = List.generate(
  50,
  (index) => Product(
    name: 'Product ${index + 1}',
    subtitle: 'Category ${index % 6 + 1}',
    category: 'Category ${index % 6 + 1}',
    price: 9.99 + index * 1.25,
    rating: 3.5 + (index % 5) * 0.3,
  ),
);
