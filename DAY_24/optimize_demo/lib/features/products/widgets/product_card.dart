import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: product.image,

          width: 60,

          placeholder: (context, url) => const CircularProgressIndicator(),

          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),

        title: Text(product.name),

        subtitle: Text("₹${product.price}"),
      ),
    );
  }
}
