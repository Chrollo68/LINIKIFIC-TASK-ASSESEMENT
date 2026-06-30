import 'package:flutter/material.dart';

import '../models/product.dart';

import '../widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final List<Product> products = [
    Product(name: "Laptop", image: "https://picsum.photos/200", price: 50000),

    Product(name: "Phone", image: "https://picsum.photos/201", price: 30000),

    Product(name: "Watch", image: "https://picsum.photos/202", price: 5000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Optimized Products")),

      body: ListView.builder(
        itemCount: products.length,

        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
