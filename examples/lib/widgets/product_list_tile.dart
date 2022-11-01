import 'package:flutter/material.dart';
import 'package:wt_app_scaffold_examples/models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.id),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('\$${product.price.toStringAsFixed(2)}'),
          Text('${product.weight} kg'),
        ],
      ),
    );
  }
}
